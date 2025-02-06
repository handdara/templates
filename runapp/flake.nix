{
    description = "Simple app runner for testing stuff pre-installation";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    inputs.flake-utils.url = "github:numtide/flake-utils";

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
            appToRun = pkgs.ncspot;
        in {
            devShells.default = pkgs.mkShell {
                nativeBuildInputs = [ appToRun ];
                buildInputs = [];
            };
        });
}
