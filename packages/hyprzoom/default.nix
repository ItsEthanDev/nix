{
  lib,
  pkgs,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "hyprzoom";
  version = "0.1.0";

  meta = {
    mainProgram = "hyprzoom";
    platforms = lib.platforms.linux;
  };

  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    install -Dm755 ${pkgs.writeShellScript "hyprzoom" ''
      if [ -z "$1" ]; then
        echo "Usage: $0 <delta>"
        exit 1
      fi

      if ! echo "$1" | ${lib.getExe pkgs.gnugrep} -Eq '^[+-]?[0-9]+(\.[0-9]+)?$'; then
        echo "Error: Delta must be a number"
        exit 1
      fi

      current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk -F': ' '{print $2}')

      new_zoom=$(echo "$current * $1" | ${lib.getExe pkgs.bc})

      if [ "$(echo "$new_zoom < 1.0" | ${lib.getExe pkgs.bc})" -eq 1 ]; then
        new_zoom=1.0
      fi

      hyprctl keyword cursor:zoom_factor "$new_zoom"
    ''} $out/bin/hyprzoom

    wrapProgram $out/bin/hyprzoom \
      --prefix PATH : ${
      lib.makeBinPath [
        pkgs.bc
        pkgs.coreutils
        pkgs.gawk
        pkgs.gnugrep
        pkgs.hyprland
      ]
    }
  '';
}
