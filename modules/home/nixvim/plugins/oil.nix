_: {
  programs.nixvim = {
    plugins = {
      oil = {
        enable = true;
        settings = {
          columns = ["icon"];
          win_options = {
            signcolumn = "yes:2";
          };
          view_options = {
            show_hidden = true;
          };
        };
      };
      oil-git-status = {
        enable = true;
        settings = {
          show_ignored = false;
        };
      };
    };

    keymaps = [
      {
        action = "<CMD>lua require('oil').toggle_float()<CR>";
        options.desc = "Open oil in a floating window";
        key = "<leader>e";
        mode = "n";
      }
    ];
  };
}
