{
  lib,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
      wallpaper = ", /home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-4,2560x1440@164.80,1920x-360,1"
      "HDMI-A-1,1920x1080@60.00,0x0,1"
      ",preferred,auto,1"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  home = {
    username = "ethan";
    homeDirectory = "/home/ethan";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;

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
