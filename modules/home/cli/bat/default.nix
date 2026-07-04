{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.bat;
in {
  options.my.cli.bat.enable = lib.mkEnableOption "bat configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      bat.enable = true;
      fish.shellAliases.cat = "bat";
      zsh.shellAliases.cat = "bat";
    };
  };
}
