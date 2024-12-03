{
    description = "handdara LaTeX template for writing documents with latexmk";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
                texRoot = "generic_doc";
                buildInputs = with pkgs; [
                    texliveFull
                ];
                nativeBuildInputs = with pkgs; [
                    just
                    okular
                ];
            in {
                packages.default = pkgs.stdenv.mkDerivation {
                    name = "tex-pdf";
                    src = ./.;
                    inherit buildInputs nativeBuildInputs;
                    buildPhase = ''
                        mkdir -p .cache/latex
                        latexmk -f -interaction=nonstopmode -file-line-error -auxdir=.cache/latex -pdf ${texRoot}.tex
                        cp ${texRoot}.tex .cache/latex
                        cd .cache/latex
                        makeindex ${texRoot}.nlo -s nomencl.ist -o ${texRoot}.nls
                        cd ../..
                        rm .cache/latex/${texRoot}.tex
                        latexmk -interaction=nonstopmode -file-line-error -synctex=1 -auxdir=.cache/latex -pdf ${texRoot}.tex
                        '';
                    installPhase = ''
                        mkdir -p $out
                        cp ${texRoot}.pdf $out
                        cp ${texRoot}.synctex.gz $out
                        '';
                };
            });
}
