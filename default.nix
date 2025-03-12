{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule rec {
  pname = "hubsync";
  version = "0.0.5";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-XemiK7qZ4HOqJ8tQBhF/KQMz0cljX8wsXR2W+9q1rOM=";

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
