{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule rec {
  pname = "hubsync";
  version = "1.0.2";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-3eyLL+o+5TJ7IYKI8mIG8Vfppk1Bgd0qg4dBPqi2eCA=";

  ldflags = [
    "-X main.versionString=v${version}"
  ];

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
