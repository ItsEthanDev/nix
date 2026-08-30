{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.terminal.herdr;
in {
  options.my.terminal.herdr = {
    enable = lib.mkEnableOption "Herdr configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.libnotify];

    programs.herdr = {
      enable = lib.mkDefault true;
      settings = {
        onboarding = lib.mkDefault false;
        theme.name = lib.mkDefault "terminal";
        ui.toast.delivery = lib.mkDefault "system";
        keys = {
          navigate_workspace_down = lib.mkDefault "j";
          navigate_workspace_up = lib.mkDefault "k";
        };
      };
    };
  };
}
