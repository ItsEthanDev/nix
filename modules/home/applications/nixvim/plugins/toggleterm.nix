_: {
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        open_mapping = "[[<C-/>]]";
        insert_mappings = true;
        terminal_mappings = true;
        start_in_insert = true;
        shade_terminals = true;
        float_opts.border = "curved";
      };
    };
  };
}
