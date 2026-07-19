{
  config,
  lib,
  ...
}: let
  cfg = config.my.gaming.mangohud;
in {
  options.my.gaming.mangohud = {
    enable = lib.mkEnableOption "MangoHud with the repository's display defaults";
    enableSessionWide = lib.mkEnableOption "injecting MangoHud into every graphical process";
  };

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = lib.mkDefault true;
      enableSessionWide = lib.mkDefault cfg.enableSessionWide;
      settings = lib.mapAttrsRecursive (_: value: lib.mkDefault value) {
        no_display = true;
        toggle_hud = "Super_L+Control_L+H";

        gpu_temp = true;
        display_server = true;
        fan = true;
        frametime = true;
        gpu_fan = true;
        ram = true;
        vram = true;
        wine = true;
        gamemode = true;
      };
    };
  };
}
