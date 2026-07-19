{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.graphics;
in {
  options.my.desktop.graphics = {
    enable = lib.mkEnableOption "the display manager and XDG portal defaults";
    autoLogin = {
      enable = lib.mkEnableOption "automatic display-manager login";
      user = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "User assigned to services.displayManager.autoLogin.user.";
      };
    };
    defaultSession = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Session passed to services.displayManager.defaultSession.";
    };
    hintWayland = lib.mkEnableOption "setting NIXOS_OZONE_WL=1 for Chromium and Electron Wayland support";
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
