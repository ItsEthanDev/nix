{buildNpmPackage}:
buildNpmPackage {
  pname = "mdts";
  version = "0.20.6";
  src = ./.;
  npmDepsHash = "sha256-upjCEWTbFEDXdqnlcpQg7HSONvvWobyC1I5VHljsTrk=";
  dontNpmBuild = true;
}
