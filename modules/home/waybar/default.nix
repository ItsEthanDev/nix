{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
  ];

  home.packages = with pkgs; [
    btop
    pamixer
    wiremix
  ];

  wayland.windowManager.hyprland.settings = lib.mkIf config.wayland.windowManager.hyprland.enable {
    "exec-once" = ["waybar"];
  };

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
  };
}
