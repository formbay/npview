{
  pkgs ? import ./pkgs.nix,
  pythonPath ? "python36"
}:
  with pkgs;
  let
    python = lib.getAttrFromPath (lib.splitString "." pythonPath) pkgs;
  in
    python.pkgs.buildPythonApplication {
      pname = "npview";
      version = "0.0.1";
      src = lib.cleanSourceWith {
        filter = (path: type:
          ! (builtins.any
              (r: (builtins.match r (builtins.baseNameOf path)) != null)
              [
                "pip_packages"
                ".*\.egg-info"
                "\.env"
                "tmp"
                "logs"
              ])
        );
        src = lib.cleanSource ./.;
      };
      propagatedBuildInputs =  (with python.pkgs; [
        numpy
        (matplotlib.override { enableQt = true; })
      ]);
    }
