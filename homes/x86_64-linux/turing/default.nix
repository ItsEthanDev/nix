{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-4,2560x1440@164.80,1920x-360,1"
      "HDMI-A-1,1920x1080@60.00,0x0,1"
      ",preferred,auto,1"
    ];

    workspace = [
      "1, monitor:DP-4, default:true"
      "2, monitor:DP-4"
      "3, monitor:DP-4"
      "4, monitor:DP-4"
      "5, monitor:DP-4"
      "6, monitor:HDMI-A-1"
      "7, monitor:HDMI-A-1"
      "8, monitor:HDMI-A-1"
      "9, monitor:HDMI-A-1"
      "0, monitor:HDMI-A-1"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  home = {
    username = "ethan";
    homeDirectory = "/home/ethan";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    javaPackages.compiler.temurin-bin.jre-17
    snes9x
    archipelago
    wine
  ];

  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = lib.getExe' pkgs.nemo-with-extensions "nemo";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };
  };
}
