tempd := justfile_directory()

runtests: _test_tex

_test_tex:
    #!/usr/bin/env bash
    set -exo pipefail
    testd=$(mktemp -d)
    cd $testd
    nix flake init -t {{tempd}}#tex
    nix build
    set +e
    res="$(fd --type f -HIL .  | fzf)" 
    set -e
    if [[ -n $res ]]; then
        nix-shell -p okular --run "okular $res"
    fi

_test_tex_env:
    #!/usr/bin/env bash
    set -exo pipefail
    testd=$(mktemp -d)
    cd $testd
    nix flake init -t {{tempd}}#tex
    export TESTD=$testd

edit:
    nvim
