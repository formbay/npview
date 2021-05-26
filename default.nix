{ buildPythonPackage
, nix-gitignore
, numpy
, matplotlib
}:

buildPythonPackage {
  pname = "npview";
  version = "1.0.0";
  src = nix-gitignore.gitignoreSource [] ./.;
  propagatedBuildInputs = [
    numpy
    matplotlib
  ];
}
