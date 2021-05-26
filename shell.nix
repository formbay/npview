{ pkgs ? import ./pkgs.nix {} }:

with pkgs;
let
  python = python38;
  drv = python.pkgs.callPackage ./default.nix {};
in
  drv.overridePythonAttrs (attrs: {
    src = null;
    nativeBuildInputs = (with python.pkgs; [
      pip
      ipython
      flake8
      black
      mypy
    ]) ++ (lib.attrByPath [ "nativeBuildInputs" ] [] attrs);
    shellHook = ''
      echo 'Entering ${attrs.pname}'
      set -o allexport
      . ./.env
      set +o allexport
      set -v

      unset SOURCE_DATE_EPOCH
      export PIP_PREFIX="$(pwd)/pip_packages"
      PIP_INSTALL_DIR="$PIP_PREFIX/lib/python${python.pythonVersion}/site-packages"
      export PYTHONPATH="$PIP_INSTALL_DIR:$PYTHONPATH"
      export PATH="$PIP_PREFIX/bin:$PATH"
      mkdir --parents "$PIP_INSTALL_DIR"

      pip install --no-use-pep517 --editable .

      set +v
    '';
  })
