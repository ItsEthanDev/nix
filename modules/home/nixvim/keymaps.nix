{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    keymaps = [
      # Better up/down
      {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "j";
        mode = ["n" "x"];
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }
      {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "k";
        mode = ["n" "x"];
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }
      # Clear highlights on escape
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = ["n" "i" "s"];
        options = {
          desc = "clear search highlight";
          silent = true;
        };
      }
      # Move to window using the <ctrl> hjkl keys
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
      # Better indent
      {
        action = "<gv";
        key = "<";
        mode = "x";
        options.silent = true;
      }
      {
        action = ">gv";
        key = ">";
        mode = "x";
        options.silent = true;
      }
      # Diagnostics
      {
        action = mkRaw "vim.diagnostic.open_float";
        key = "<leader>cd";
        mode = "n";
        options = {
          desc = "Line Diagnostics";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = 1, float = true})
          end
        '';
        key = "]d";
        mode = "n";
        options = {
          desc = "Next Diagnostic";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = -1, float = true})
          end
        '';
        key = "[d";
        mode = "n";
        options = {
          desc = "Prev Diagnostic";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = 1, severity = vim.diagnostic.severity.ERROR, float = true})
          end
        '';
        key = "]e";
        mode = "n";
        options = {
          desc = "Next Error";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = -1, severity = vim.diagnostic.severity.ERROR, float = true})
          end
        '';
        key = "[e";
        mode = "n";
        options = {
          desc = "Prev Error";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = 1, severity = vim.diagnostic.severity.WARN, float = true})
          end
        '';
        key = "]w";
        mode = "n";
        options = {
          desc = "Next Warning";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            vim.diagnostic.jump({count = -1, severity = vim.diagnostic.severity.WARN, float = true})
          end
        '';
        key = "[w";
        mode = "n";
        options = {
          desc = "Prev Warning";
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
        lspBufAction = "declaration";
      }
      {
        key = "gr";
        lspBufAction = "references";
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
      }
      {
        key = "gI";
        lspBufAction = "implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "gK";
        lspBufAction = "signature_help";
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
