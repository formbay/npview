{ pkgs ? import ./pkgs.nix {} }:

with pkgs;
let
  python = python39;
in
  rec {
    library = python.pkgs.callPackage ./default.nix {};
    application = python.pkgs.toPythonApplication library;
    docker = dockerTools.buildImage {
      name = application.name;
      contents = [ application ];
      extraCommands = ''
        mkdir -m 1777 tmp
      '';
      config = {
        Cmd = [ "/bin/npview" ];
      };
    };
  }
