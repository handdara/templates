{
    description = "basic zig flake template, with an arg parser lib";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        clap.url = "github:Hejsil/zig-clap/0.9.1";
        clap.flake = false;
    };

    outputs = { nixpkgs, flake-utils, ... }@inputs:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};
                # zig = pkgs.zig_0_12;
                nativeBuildInputs = with pkgs; [
                    zig
                    zls
                    lldb
                ];

                buildInputs = [];

                preBuild = ''
                    zig fetch --save ${inputs.clap}
                '';
            in {
                devShells.default = pkgs.mkShell {
                    inherit nativeBuildInputs buildInputs preBuild;
                };
                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "z.out";
                    version = "24.0.0";
                    src = ./.;

                    # postInstall = ''
                    #     echo "zigDefaultFlagsArray" $zigDefaultFlagsArray > $out/dump.log
                    #     echo "zigBuildFlags" $zigBuildFlags >> $out/dump.log
                    #     echo "zigBuildFlagsArray" $zigBuildFlagsArray >> $out/dump.log
                    #     echo "zigInstallFlags" $zigInstallFlags >> $out/dump.log
                    #     echo "zigInstallFlagsArray" $zigInstallFlagsArray >> $out/dump.log
                    #     '';

                    nativeBuildInputs = nativeBuildInputs ++ [ pkgs.zig.hook ];

                    inherit buildInputs preBuild;

                    doCheck = true;
                };
            }
        );
}
