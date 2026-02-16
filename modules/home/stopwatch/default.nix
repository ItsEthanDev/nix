{
  config,
  lib,
  pkgs,
  ...
}: let
  ghosttyTransparent = let
    xdgConfigHome = pkgs.runCommand "ghostty-transparent-xdg-config-home" {} ''
      mkdir -p "$out/ghostty"
      cat > "$out/ghostty/config" <<EOF
      background-opacity = 0
      confirm-close-surface = false
      EOF
    '';
  in
    pkgs.writeShellScriptBin "ghostty-transparent" ''
      export XDG_CONFIG_HOME=${xdgConfigHome}
      exec ${pkgs.ghostty}/bin/ghostty "$@"
    '';
  stopwatchApp = pkgs.symlinkJoin {
    name = "stopwatch-app";
    paths = [pkgs.peaclock];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = let
      configFile = pkgs.writeText "stopwatch.conf" ''
        mode stopwatch
        stopwatch 00h:00m:00s
        stopwatch start
        view digital
        block 1 1
        padding 0 0
        margin 0 0
        set seconds on
        set date off
        set auto-size off
        set auto-ratio off
        rate-status 1
        style prompt clear
        style success clear
        style error clear
        style text clear
      '';
    in ''
      wrapProgram $out/bin/peaclock \
        --argv0 stopwatch \
        --run 'config_dir="/tmp/peaclock-stopwatch"; ${pkgs.coreutils}/bin/mkdir -p "$config_dir/history"' \
        --append-flags "--config-dir /tmp/peaclock-stopwatch --config ${configFile}"
      ln -s $out/bin/peaclock $out/bin/stopwatch-app
    '';
  };
  stopwatchLauncher = pkgs.writeShellScriptBin "stopwatch" ''
    exec ${ghosttyTransparent}/bin/ghostty-transparent \
      --title=${lib.escapeShellArg config.my.stopwatch.title} \
      -e ${stopwatchApp}/bin/stopwatch-app "$@"
  '';
in {
  options = {
    my.stopwatch = {
      launch = lib.mkOption {
        type = lib.types.str;
        description = "Command-line string used to launch the stopwatch application";
        default = "${stopwatchLauncher}/bin/stopwatch";
      };
      title = lib.mkOption {
        type = lib.types.str;
        description = "Title of the stopwatch application";
        default = "stopwatch";
      };
    };
  };

  config = {
    home.packages = [
      stopwatchLauncher
    ];
  };
}
