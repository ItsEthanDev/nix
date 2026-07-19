{
  config,
  lib,
  ...
}: let
  cfg = config.my.terminal.zsh;
in {
  options.my.terminal.zsh.enable = lib.mkEnableOption "zsh configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      zsh = {
        enable = lib.mkDefault true;
        syntaxHighlighting = {
          enable = lib.mkDefault true;
          highlighters = lib.mkDefault [
            "main"
            "brackets"
            "pattern"
            "cursor"
            "regexp"
            "root"
            "line"
          ];
        };
        autosuggestion = {
          enable = lib.mkDefault true;
          strategy = lib.mkDefault ["completion"];
        };
        oh-my-zsh = {
          enable = lib.mkDefault true;
          plugins = lib.mkDefault [
            "vi-mode"
          ];
        };
        initContent = lib.mkDefault ''
          # Autosuggestion completion
          bindkey '^Y' autosuggest-accept
        '';
      };
    };
  };
}
