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
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };

      fish.shellAliases.cd = "z";
      zsh.shellAliases.cd = "z";
    };
  };
}
