{
    stdenv,
    gfortran,
    fortranStd,
}: let
    mainObj = stdenv.mkDerivation rec {
        name = "main.o";
        src = ./src;
        buildInputs = [gfortran];
        buildPhase = ''
            ${gfortran}/bin/gfortran -c -std=${fortranStd} main.f90
        '';
        dontFixup = true;
        installPhase = ''
            mkdir -p $out
            cp ${name} $out/${name}
        '';
    };
in
    stdenv.mkDerivation rec {
        name = "f.out";
        src = ./.;
        buildInputs = [gfortran];
        buildPhase = ''
            ${gfortran}/bin/gfortran -std=${fortranStd} ${mainObj}/${mainObj.name} -o ${name}
        '';
        installPhase = ''
            mkdir -p $out/bin
            cp ${name} $out/bin/${name}
        '';
    }
