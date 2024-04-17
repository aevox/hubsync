package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"sync"

	"github.com/google/go-github/v61/github"
	"golang.org/x/oauth2"
)

func syncRepo(wg *sync.WaitGroup, repo *github.Repository, directory string, semaphore chan struct{}) {
	defer wg.Done()

	semaphore <- struct{}{}
	clonePath := filepath.Join(directory, *repo.Name)

	if _, err := os.Stat(clonePath); os.IsNotExist(err) {
		cmd := exec.Command("git", "clone", repo.GetSSHURL(), clonePath)
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Error cloning repository %s: %v\n", *repo.Name, err)
		} else {
			fmt.Printf("Successfully cloned %s into %s\n", *repo.Name, clonePath)
		}
	} else {
		cmd := exec.Command("git", "-C", clonePath, "pull")
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Error updating repository %s: %v\n", *repo.Name, err)
		} else {
			fmt.Printf("Successfully updated %s\n", *repo.Name)
		}
	}

	<-semaphore
}

func main() {
	orgPtr := flag.String("org", "", "The name of the GitHub organization.")
	userPtr := flag.String("user", "", "The GitHub user name.")
	dirPtr := flag.String("dir", ".", "The directory to clone the repositories into.")
	privatePtr := flag.Bool("private", false, "Fetch all repositories, including private ones.")
	flag.Parse()

	if *orgPtr == "" && *userPtr == "" {
		fmt.Println("You must specify either --org or --user.")
		os.Exit(1)
	}

	entity := strings.TrimSpace(*orgPtr + *userPtr)
	directory := strings.TrimSpace(*dirPtr)
	repoType := "public"
	if *privatePtr {
		repoType = "all"
	}

	ctx := context.Background()
	token := os.Getenv("GITHUB_TOKEN")
	if token == "" && *privatePtr {
		fmt.Println("GITHUB_TOKEN environment variable is not set for accessing private repositories")
		os.Exit(1)
	}

	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: token},
	)
	tc := oauth2.NewClient(ctx, ts)

	client := github.NewClient(tc)

	var allRepos []*github.Repository

	if *orgPtr != "" {
		opt := &github.RepositoryListByOrgOptions{Type: repoType, ListOptions: github.ListOptions{PerPage: 100}}
		for {
			repos, resp, err := client.Repositories.ListByOrg(ctx, entity, opt)
			if err != nil {
				fmt.Println("Error fetching repositories:", err)
				os.Exit(1)
			}
			allRepos = append(allRepos, repos...)
			if resp.NextPage == 0 {
				break
			}
			opt.Page = resp.NextPage
		}
	} else {
		opt := &github.RepositoryListOptions{Type: repoType, ListOptions: github.ListOptions{PerPage: 100}}
		for {
			repos, resp, err := client.Repositories.List(ctx, entity, opt)
			if err != nil {
				fmt.Println("Error fetching repositories:", err)
				os.Exit(1)
			}
			allRepos = append(allRepos, repos...)
			if resp.NextPage == 0 {
				break
			}
			opt.Page = resp.NextPage
		}
	}

	var wg sync.WaitGroup
	semaphore := make(chan struct{}, 10)

	for _, repo := range allRepos {
		wg.Add(1)
		go syncRepo(&wg, repo, directory, semaphore)
	}

	wg.Wait()
}
