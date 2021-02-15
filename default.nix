{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "tremor";
  version = "0.10.1";

  src = pkgs.fetchFromGitHub {
    owner = "tremor-rs";
    repo = "tremor-runtime";
    rev = "v${version}";
    sha256 = "1z1khxfdj2j0xf7dp0x2cd9kl6r4qicp7kc4p4sdky2yib66512y";
  };

  cargoSha256 = "sha256-rN/d6BL2d0D0ichQR6v0543Bh/Y2ktz8ExMH50M8B8c=";

  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config pkgs.installShellFiles ];

  buildInputs = [ pkgs.zlib pkgs.openssl pkgs.llvmPackages.libclang ];
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.darwin.apple_sdk.frameworks.Security pkgs.darwin.apple_sdk.frameworks.CoreServices ];

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang}/lib";

  OPENSSL_NO_VENDOR = 1;

  cargoBuildFlags = [ "--all" ];

  postInstall = ''
    installShellCompletion --cmd tremor \
      --bash <($out/bin/tremor completions bash) \
      --fish <($out/bin/tremor completions fish) \
      --zsh <($out/bin/tremor completions zsh)
  '';

  meta = with pkgs.lib; {
    description =
      "Early stage event processing system for unstructured data with rich support for structural pattern matching, filtering and transformation";
    homepage = "https://www.tremor.rs/";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
    maintainers = with maintainers; [ humancalico ];

  };
}
