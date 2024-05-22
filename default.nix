{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule {
  pname = "hubsync";
  version = "0.0.1";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-cpVgC2Su/sFVVLHJ+7/c4slk3LfALPlNfWHaTb987c8=";

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
