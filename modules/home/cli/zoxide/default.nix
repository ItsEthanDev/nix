{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.zoxide;
in {
  options.my.cli.zoxide.enable = lib.mkEnableOption "zoxide configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      zoxide = {
        enable = lib.mkDefault true;
        enableZshIntegration = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
      };

      fish.shellAliases.cd = "z";
      zsh.shellAliases.cd = "z";
    };
  };
}
