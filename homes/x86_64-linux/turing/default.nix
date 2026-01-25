{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
      wallpaper = ", /home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,2560x1440@143.97,0x0,1"
      ",preferred,auto,1"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = "${pkgs.nemo-with-extensions}/bin/nemo";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };
  };
}
