{
    description = "handdara typst template for writing documents";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
                typstRoot = "main";
                buildInputs = with pkgs; [
                    typst
                ];
                nativeBuildInputs = with pkgs; [
                    just
                    zathura
                ];
            in {
                packages.default = pkgs.stdenv.mkDerivation {
                    name = "typ-pdf";
                    src = ./.;
                    inherit buildInputs nativeBuildInputs;
                    buildPhase = ''
                        typst compile ${typstRoot}.typ ${typstRoot}.pdf
                    '';
                    installPhase = ''
                        mkdir -p $out
                        cp ${typstRoot}.pdf $out/built.pdf
                    '';
                };
            });
}
