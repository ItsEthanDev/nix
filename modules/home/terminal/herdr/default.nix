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
    home.packages = lib.optionals pkgs.stdenv.isLinux [pkgs.libnotify];

    programs.herdr = {
      enable = lib.mkDefault true;
      settings.theme.name = lib.mkDefault "terminal";
    };
  };
}
