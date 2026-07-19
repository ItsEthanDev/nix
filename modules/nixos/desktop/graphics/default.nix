{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.graphics;
in {
  options.my.desktop.graphics = {
    enable = lib.mkEnableOption "Desktop display manager";
    autoLogin = {
      enable = lib.mkEnableOption "Auto login";
      user = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "User to auto login";
      };
    };
    defaultSession = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Session name of the session to use by default";
    };
    hintWayland = lib.mkEnableOption "Hint electron and chromium apps to use wayland";
  };

  config = lib.mkIf cfg.enable {
    xdg.portal.enable = lib.mkDefault true;
    services.displayManager = {
      enable = lib.mkDefault true;
      autoLogin = lib.mkIf cfg.autoLogin.enable {
        enable = lib.mkDefault true;
        user = lib.mkIf (cfg.autoLogin.user != null) (lib.mkDefault cfg.autoLogin.user);
      };
      defaultSession = lib.mkDefault cfg.defaultSession;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = lib.mkIf cfg.hintWayland (lib.mkDefault "1");
  };
}
