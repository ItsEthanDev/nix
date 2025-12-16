{...}: {
  catppuccin.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
      wallpaper = ", /home/ethan/nix/static/wallpapers/spirals-2560x2560.png";
    };
  };

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
