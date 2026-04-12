{...}: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options = {
          desc = "clear search highlight";
          silent = true;
        };
      }
      {
        action = "<C-w>h";
        key = "<C-h>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = "x";
        options = {
          desc = "move selection down";
          silent = true;
        };
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = "x";
        options = {
          desc = "move selection up";
          silent = true;
        };
      }
      {
        action = "<cmd>lua vim.diagnostic.open_float(nil, {scope = 'cursor'})<CR>";
        key = "<leader>cd";
        mode = "n";
        options = {
          desc = "show cursor diagnostics";
          silent = true;
        };
      }
    ];
    lsp.keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gD";
        lspBufAction = "references";
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "<leader>ca";
        lspBufAction = "code_action";
      }
      {
        key = "<leader>cr";
        lspBufAction = "rename";
      }
    ];
  };
}
