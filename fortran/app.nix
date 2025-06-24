{
    gfortran,
    fortranStd,
    pkgs,
}: let
    mkObj = root: modDeps:
        pkgs.callPackage ./src/obj.nix {
            inherit fortranStd modDeps;
            srcFileRoot = root;
        };
    flip = mkObj "flip" [];
    main = mkObj "main" [flip];
    objs = builtins.foldl' (acc: x: acc + "${x}/${x.name} ") "" [flip main];
    mods = builtins.foldl' (acc: x: acc + "-I ${x}/build ") "" [flip main];
in
    pkgs.stdenv.mkDerivation rec {
        name = "f.out";
        src = ./.;
        buildInputs = [gfortran];
        buildPhase = ''
            ${gfortran}/bin/gfortran -std=${fortranStd} ${objs} ${mods} -o ${name}
        '';
        installPhase = ''
            mkdir -p $out/bin
            cp ${name} $out/bin/${name}
        '';
    }
