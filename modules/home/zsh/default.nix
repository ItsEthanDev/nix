{...}: {
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
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
}
