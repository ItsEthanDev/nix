{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.waybar;
in {
  options.my.desktop.waybar.enable = lib.mkEnableOption "Waybar configuration";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = lib.mkIf config.wayland.windowManager.hyprland.enable {
      "exec-once" = ["waybar"];
    };

    programs.waybar = {
      enable = true;
      settings = import ./settings.nix {inherit config lib pkgs;};
      style = import ./style.nix;
    };
  };
}
