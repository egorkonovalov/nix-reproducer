{
  description = "Hello package";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let

        pkgs = import nixpkgs { inherit system; };

        hello-test = pkgs.stdenv.mkDerivation rec {
          name = "Hello Test";
          pname = "hello-test";
          version = "0.1";

          src = ./src;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out
            cp -r dist/. $out
          '';

          postInstall = ''
            wrapProgram $out/bin/hello-test $out/run.sh
          '';

          meta = {
            description = "Hello world run via run.sh";
            mainProgram = "run.sh";
          };
        };
      in
      {
        packages.default = hello-test;
        devShells.default = pkgs.mkShell {
          packages = [
            hello-test
          ];
        };
      }
    );
}
