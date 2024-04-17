{
  description = "A flake using toolkit and its nixpkgs";

  inputs = {
    # We get nixpkgs from nix-toolkit.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # This is a nice to have lib to manage different systems.
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        # Used in command `nix fmt` to format files.
        formatter = pkgs.alejandra;

        # What is going to be installed when using `nix shell 'git+ssh://git.github.com/happn-app/<your-repo>'`.
        packages.default = import ./default.nix {inherit pkgs;};

        # List of packages in the environment when using `nix develop` or direnv.
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.go
          ];
          buildInputs = [
            pkgs.git
          ];
        };
      }
    );
}
