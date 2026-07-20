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
          highlighters = [
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
          strategy = ["completion"];
        };
        oh-my-zsh = {
          enable = lib.mkDefault true;
          plugins = [
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
