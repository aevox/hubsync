# hubsync

hubsync is a command-line utility designed to facilitate the synchronization of GitHub repositories locally.

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
- `--archived`: Includes archived repositories in the fetch operation.

## Prerequisites

- **Go (Golang)**: Ensure Go installed on your system to build hubsync.
- **Git**: Git must be installed on your system for cloning and updating repository operations.
- **GitHub Personal Access Token**: For private repository synchronization, a GitHub personal access token with `repo` scope is required.

- **Nix (optional)**: Nix can be used to build the binary.

## Build:


```bash
go build
```

## Install:
### With Go

```
go install github.com/aevox/hubsync@latest
```

### With Nix
```
nix profile add github.com/aevox:hubsync
```
