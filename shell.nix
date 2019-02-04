{
  pkgs ? import ./pkgs.nix,
  pythonPath ? "python36"
}:
  with pkgs;
  let
    python = lib.getAttrFromPath (lib.splitString "." pythonPath) pkgs;
    drv = import ./default.nix { inherit pkgs pythonPath; };
  in
    drv.overrideAttrs (attrs: {
      src = null;
      shellHook = ''
        echo 'Entering ${attrs.pname}'
        set -v

        unset SOURCE_DATE_EPOCH
        export PIP_PREFIX="$(pwd)/pip_packages"
        PIP_INSTALL_DIR="$PIP_PREFIX/lib/python${python.majorVersion}/site-packages"
        export PYTHONPATH="$PIP_INSTALL_DIR:$PYTHONPATH"
        export PATH="$PIP_PREFIX/bin:$PATH"
        mkdir --parents "$PIP_INSTALL_DIR"
        # avoid bringing in elasticsearch via --no-deps
        pip install --editable .

        set +v
      '';
    })
