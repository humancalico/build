{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  rustPlatform = pkgs.rustPlatform;
  pkg-config = pkgs.pkg-config;
  fetchFromGitHub = pkgs.fetchFromGitHub;
in
rustPlatform.buildRustPackage rec {
  pname = "volta";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "volta-cli";
    repo = "volta";
    rev = "v${version}";
    sha256 = "015mm9i69ymzypf7a67nnmvr2k0s8wrywz1k1vq602x2xsbd6a2n";
  };

  cargoSha256 = "sha256-IE+0a2/aWIAXQIeJByekJaZsejw0ehfhnq85ooAlbV8=";

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description =
      "The Hassle-Free JavaScript Tool Manager";
    homepage = "https://volta.sh/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ humancalico ];
  };
}
