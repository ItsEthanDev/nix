_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings.sections = {
      lualine_x = [
        # Shows pending command keys
        "%S"
      ];
    };
  };
}
