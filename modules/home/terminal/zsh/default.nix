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
        enable = true;
        syntaxHighlighting = {
          enable = true;
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
          enable = true;
          strategy = ["completion"];
        };
        oh-my-zsh = {
          enable = true;
          plugins = [
            "vi-mode"
          ];
        };
        initContent = ''
          # Autosuggestion completion
          bindkey '^Y' autosuggest-accept
        '';
      };
    };
  };
}
