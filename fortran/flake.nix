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
                fortls
                alejandra
                just
            ];
            buildInputs = with pkgs; [
                gfortran
            ];
            fortranStd = "f2018";
        in {
            devShells.default = pkgs.mkShell {
                inherit nativeBuildInputs buildInputs;
            };
            packages.default = pkgs.callPackage ./app.nix {inherit fortranStd;};
        });
}
