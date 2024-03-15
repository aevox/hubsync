{ pkgs ? import <nixpkgs> {} }:

pkgs.buildGoModule rec {
  pname = "hubsync";
  version = "0.0.0";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = null;

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
