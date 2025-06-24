{
    srcFileRoot,
    stdenv,
    gfortran,
    fortranStd,
    modDeps ? [],
}:
let
    extraFlags = builtins.foldl' (acc: x: acc + "-I ${x}/build ") "" modDeps; 
in
stdenv.mkDerivation rec {
    obj = "${srcFileRoot}.o";
    name = obj;
    src = ./.;
    buildInputs = [gfortran];
    buildPhase = ''
        mkdir build
        ${gfortran}/bin/gfortran -c -std=${fortranStd} ${srcFileRoot}.f90 -J build ${extraFlags}
    '';
    dontFixup = true;
    installPhase = ''
        mkdir -p $out
        cp ${obj} $out/${obj}
        cp -r build $out/build
    '';
}
