{
    description = "basic python flake, incomplete";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        py-rps.url = "github:robotarium/robotarium_python_simulator";
        py-rps.flake = false;
    };

    outputs = { nixpkgs, flake-utils, py-rps, ... }:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};

                python = pkgs.python312;
                existingBuildInputs = [
                    (python.withPackages (ps: with ps; [
                        numpy
                        matplotlib
                        cvxopt
                        scipy
                        setuptools 
                    ]))
                ];
                propagatedBuildInputs = 
                    existingBuildInputs 
                    ++ [(import ./rps.nix {inherit python py-rps existingBuildInputs;})];
                nativeBuildInputs = with pkgs; [
                    python
                    pyright
                    (python.withPackages (ps: with ps; [
                        python-lsp-server 
                    ]))
                ] ++ propagatedBuildInputs;

                buildInputs = [];
            in {
                # devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};

                packages.default = python.pkgs.buildPythonApplication {
                    pname = ".main.py-wrapped";
                    version = "0.0.0";
                    format = "setuptools";

                    src = ./.;

                    # True if tests
                    doCheck = false;

                    inherit nativeBuildInputs buildInputs propagatedBuildInputs;
                };
            }
        );
}
