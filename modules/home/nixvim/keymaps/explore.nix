_: {
  programs.nixvim.keymaps = [
    # Explore
    {
      action = "<Cmd>lua MiniFiles.open()<CR>";
      key = "<space>ed";
      mode = ["n"];
      options = {
        desc = "Directory";
      };
    }
    {
      action = "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>";
      key = "<space>ef";
      mode = ["n"];
      options = {
        desc = "File directory";
      };
    }
  ];
}
