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
        theme.name = lib.mkDefault "terminal";
        ui.toast.delivery = lib.mkDefault "system";
      };
    };
  };
}
