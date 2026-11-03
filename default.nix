{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule rec {
  pname = "hubsync";
  version = "1.0.2";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-8km3mxTFLZbU1OaY8kRzLCqTsdGL22nky2XVqH5ns1Q=";

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
