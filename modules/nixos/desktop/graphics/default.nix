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
    xdg.portal.enable = true;
    services.displayManager = {
      enable = true;
      autoLogin = lib.mkIf cfg.autoLogin.enable {
        enable = true;
        user = lib.mkIf (cfg.autoLogin.user != null) cfg.autoLogin.user;
      };
      defaultSession = cfg.defaultSession;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = lib.mkIf cfg.hintWayland "1";
  };
}
