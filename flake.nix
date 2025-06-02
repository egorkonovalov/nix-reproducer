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
            substitute $out/run.sh $out/bin/run-hello-test \
                --replace-fail "./bin/hello-test" "exec $out/bin/hello-test"
            chmod +x $out/bin/run-hello-test
          '';
          meta = {
            description = "Hello world run via run.sh";
            mainProgram = "run-hello-test";
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
