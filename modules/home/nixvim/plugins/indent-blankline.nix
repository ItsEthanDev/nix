_: {
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings.indent = {
      char = "│";
      tab_char = "│";
    };
  };
}
