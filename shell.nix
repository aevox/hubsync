{ pkgs ? import <nixpkgs> {} }:

let
  hubsync = import ./default.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = [ hubsync pkgs.go pkgs.git ];

  shellHook = ''
    echo "hubsync binary and development tools are available."
  '';
}
