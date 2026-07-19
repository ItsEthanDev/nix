{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.eza;
  shellAliases = {
    ls = "eza --icons=always";
    ll = "eza -lh";
    l = "eza -lah";
    tree = "eza -T";
  };
in {
  options.my.cli.eza.enable = lib.mkEnableOption "eza configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      eza = {
        enable = lib.mkDefault true;
        enableZshIntegration = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
        git = lib.mkDefault true;
        icons = lib.mkDefault "auto";
      };

      fish.shellAliases = shellAliases;
      zsh.shellAliases = shellAliases;
    };
  };
}
