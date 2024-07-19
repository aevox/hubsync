{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule {
  pname = "hubsync";
  version = "0.0.2";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-BzJ4byFlYLKVgjcUIFXtYXG/CCBeZ5CUyKvIth6tKrw=";

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
