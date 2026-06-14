{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options
  ];

  options = {};

  config = {
    my.apps = {
      ai.command = "${lib.getExe pkgs.ghostty} --confirm-close-surface=false -e ${lib.getExe pkgs.opencode}";
      audio.command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.wiremix}";
      bluetooth.command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.bluetui}";
      browser.command = lib.getExe inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
      launcher.command = lib.getExe pkgs.walker;
      network.command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.impala}";
      terminal.command = lib.getExe pkgs.ghostty;
      top.command = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.btop}";
    };
  };
}
