{pkgs}:
pkgs.runCommand "documentation" {nativeBuildInputs = [pkgs.nodejs];} ''
  node ${./check-documentation.mjs} ${../.}
  touch "$out"
''
