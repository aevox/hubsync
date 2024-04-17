{ pkgs ? import <nixpkgs> {} }:

pkgs.buildGoModule {
  pname = "hubsync";
  version = "0.0.0";

  # Specify the source directory.
  src = ./.;

  # Enable vendoring support.
  vendorHash = "sha256-gPcmc6LeYJjd+SdaT10sX+03uCd5bv59rzzN1WwIZLM=";

  # Metadata for the package.
  meta = {
    description = "Synchronize GitHub repositories locally";
    homepage = "https://github.com/aevox/hubsync";
    license = pkgs.lib.licenses.mit;
  };
}
