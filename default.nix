{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  rustPlatform = pkgs.rustPlatform;
  pkg-config = pkgs.pkg-config;
  fetchFromGitHub = pkgs.fetchFromGitHub;
in
rustPlatform.buildRustPackage rec {
  pname = "volta";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "volta-cli";
    repo = "volta";
    rev = "v${version}";
    sha256 = "sha256-6ZXS87upd8QAzaatDXQU5/akpAYIFNTNCK70dUlr31s=";
  };

  cargoSha256 = "sha256:0rx63qlxj6ij96ca3h9cr73xq04qckf25zildszxr9gq9iv362z5";

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description =
      "The Hassle-Free JavaScript Tool Manager";
    homepage = "https://volta.sh/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ humancalico ];
  };
}
