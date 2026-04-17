{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule rec {
  pname = "hubsync";
  version = "1.0.1";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-I71f2z/oHc2oLsFVbZBogXFq9oC1V48r0PWyKLXLwUE=";

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
