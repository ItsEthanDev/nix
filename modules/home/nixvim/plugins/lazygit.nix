_: {
  programs.nixvim = {
    plugins.lazygit.enable = true;

    keymaps = [
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "Open LazyGit";
      }
    ];
  };
}
