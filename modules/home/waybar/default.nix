{
  config,
  lib,
  ...
}: {
  imports = [
    ./settings.nix
    ./style.nix
  ];

  wayland.windowManager.hyprland.settings = lib.mkIf config.wayland.windowManager.hyprland.enable {
    "exec-once" = ["waybar"];
  };

  programs.waybar.enable = true;
}
