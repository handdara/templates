{
    description = "basic zig project template";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};
                nativeBuildInputs = with pkgs; [
                    zig
                    zls
                ];

                buildInputs = [];
            in {
                devShells.default = pkgs.mkShell {
                    inherit nativeBuildInputs buildInputs;
                };

                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "z.out";
                    version = "yy.mm.minor.micro";
                    src = ./.;

                    nativeBuildInputs =
                        nativeBuildInputs
                        ++ [
                            pkgs.zig.hook
                        ];
                    inherit buildInputs;

                    doCheck = true;
                };
            }
        );
}
