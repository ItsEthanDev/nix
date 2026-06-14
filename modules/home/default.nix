{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options
  ];

  config.my = {
    apps = {
      ai = {
        command = "${lib.getExe pkgs.ghostty} --confirm-close-surface=false -e ${lib.getExe pkgs.opencode}";
      };
      audio = {
        command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.wiremix}";
        activate = "hyprctl dispatch togglespecialworkspace audio";
      };
      bluetooth = {
        command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.bluetui}";
        activate = "hyprctl dispatch togglespecialworkspace bluetooth";
      };
      browser = {
        command = lib.getExe inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
      launcher = {
        command = lib.getExe pkgs.walker;
      };
      network = {
        command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.impala}";
        activate = "hyprctl dispatch togglespecialworkspace network";
      };
      terminal = {
        command = lib.getExe pkgs.ghostty;
      };
      top = {
        command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.btop}";
        activate = "hyprctl dispatch togglespecialworkspace top";
      };
    };
    clipboard = {
      copy.command =
        if pkgs.stdenv.isLinux
        then lib.getExe' pkgs.wl-clipboard "wl-paste"
        else "pbcopy";
      history.launch = "${config.my.apps.launcher.command} --provider clipboard";
    };
    desktop.wallpaper = ../../static/wallpapers/spirals-2560x2560.png;
  };
}
