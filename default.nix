{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule {
  pname = "hubsync";
  version = "0.0.0";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-+GzzgPfomOZ6EJaeeirBI94sBY8eMu8gsVd/ehIWzLE=";

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
