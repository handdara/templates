{
    description = "basic handdara FORTRAN env flake";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = {
        self,
        nixpkgs,
        flake-utils,
    }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
            nativeBuildInputs = with pkgs; [
                fortran-language-server
                just
            ];
            buildInputs = with pkgs; [                
                gfortran
            ];
            main = "main";
        in {
            devShells.default = pkgs.mkShell {
                inherit nativeBuildInputs buildInputs;
            };
            packages.default = pkgs.stdenv.mkDerivation rec {
                pname = "f.out";
                version = "25.06.0.0";
                src = ./.;
                inherit buildInputs nativeBuildInputs;
                buildPhase = ''
                  ${pkgs.gfortran}/bin/gfortran ${main}.f90 -o ${pname}
                '';
                installPhase = ''
                  mkdir -p $out/bin
                  cp ${pname} $out/bin/${pname}
                '';
            };
        });
}
