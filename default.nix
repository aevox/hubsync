{pkgs ? import <nixpkgs> {}}:
pkgs.buildGoModule {
  pname = "hubsync";
  version = "0.0.3";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-L1PCY4yGnOkcX82/hapkBPn7weQweThyh+D3PQSWUAY=";

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
