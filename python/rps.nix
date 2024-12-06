# rps.nix
{
    py-rps,
    python,
    existingBuildInputs,
}:
python.pkgs.buildPythonPackage {
    pname = "robotarium_python_simulator";
    version = "master";
    src = py-rps;
    doCheck = false; # do not run tests
    dependencies = existingBuildInputs;
    pyproject = true;
    build-system = [
        python.pkgs.setuptools
    ];
}
