{
    description = "Advent of Code 2024 in Zig";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        zig-flags.url = "github:n0s4/flags";
        zig-flags.flake = false;
    };

    outputs = {
        nixpkgs,
        flake-utils,
        ...
        }@inputs:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};
                nativeBuildInputs = with pkgs; [
                    zig
                    zls
                ];

                buildInputs = [];
                
                # ENVS
                ZIG_FLAGS = inputs.zig-flags + /src;
            in {
                devShells.default = pkgs.mkShell {
                    inherit nativeBuildInputs buildInputs ZIG_FLAGS;
                };

                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "zoc";
                    version = "24.0.0";
                    src = ./.;

                    nativeBuildInputs =
                        nativeBuildInputs
                        ++ [
                            pkgs.zig.hook
                        ];
                    inherit buildInputs ZIG_FLAGS;

                    doCheck = true;
                };
            }
        );
}
