{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;

  lspPicker = picker: title:
    mkRaw ''
      function()
        require("telescope.builtin").${picker}({
          prompt_title = "${title}",
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        })
      end
    '';
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
        mode = ["n"];
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
        action = mkRaw ''function() require("actions-preview").code_actions() end'';
        key = "<leader>ca";
        mode = ["n" "v"];
        options = {
          desc = "Code Actions";
          silent = true;
        };
      }
      {
        action = lspPicker "lsp_definitions" "Definitions";
        key = "gd";
        mode = "n";
        options = {
          desc = "Goto Definition";
          silent = true;
        };
      }
      {
        action = lspPicker "lsp_references" "References";
        key = "gr";
        mode = "n";
        options = {
          desc = "References";
          silent = true;
        };
      }
    ];
    lsp.keymaps = [
      {
        key = "gD";
        lspBufAction = "declaration";
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
        key = "<leader>cr";
        lspBufAction = "rename";
      }
    ];
  };
}
