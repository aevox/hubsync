# hubsync

hubsync is a command-line utility designed to facilitate the synchronization of GitHub repositories. It provides a straightforward way to clone and update repositories from a specified user or organization on GitHub. The utility leverages concurrency to enhance the efficiency of the synchronization process, ensuring timely updates of your local copies with the latest changes from GitHub.

## Features

- **Default Public Repository Synchronization**: By default, hubsync fetches only public repositories, ensuring quick synchronization without additional setup.
- **Optional Private Repository Synchronization**: With the `--private` flag, hubsync can also fetch private repositories, providing a comprehensive synchronization capability.
- **Concurrency Control**: hubsync performs cloning and updating operations concurrently, significantly reducing the total time required for synchronization.
- **User and Organization Support**: Whether you need to synchronize repositories from a user account or an organization, hubsync has you covered.

## Prerequisites

- **Go (Golang)**: Ensure Go is installed on your system to run hubsync.
- **Git**: Git must be installed on your system for cloning and updating repository operations.
- **GitHub Personal Access Token**: For private repository synchronization, a GitHub personal access token with `repo` scope is required.

## Setup and Installation

Clone or download the hubsync script to your local machine.
You can build the binary either with Nix or directly with Golang.

### Nix:

Install [Nix](https://nixos.org/download/):

On Linux:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

On MacOS:
```bash
sh <(curl -L https://nixos.org/nix/install)
```

Create a shell environment ( It installs golang, builds and exposes the binary )

```bash
nix-shell
```

### Go:

Install [Go](https://go.dev/doc/install) > 1.21.5:

```bash
go build
```


## Usage

To synchronize public repositories from a GitHub user:

```
GITHUB_TOKEN=xxxxxxxx  hubsync --user=username --dir=target_directory
```

To synchronize all repositories, including private ones, from a GitHub organization:

```
GITHUB_TOKEN=xxxxxxxx  hubsync --user=username --dir=target_directory --private
```

### Flags

- `--user`: Specifies a GitHub user account from which to fetch repositories.
- `--org`: Specifies a GitHub organization from which to fetch repositories.
- `--dir`: Sets the target directory for cloned or updated repositories. Defaults to the current directory if not specified.
- `--private`: Includes private repositories in the fetch operation.

## License

hubsync is made available under the MIT License.
