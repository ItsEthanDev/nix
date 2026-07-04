{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking text";
        command = "lua vim.highlight.on_yank()";
      }
      {
        event = ["FocusGained" "BufEnter" "CursorHold" "CursorHoldI"];
        desc = "Reload files changed outside Neovim";
        command = "if mode() != 'c' | checktime | endif";
      }
      {
        event = "FileChangedShellPost";
        desc = "Notify after reloading changed file";
        command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None";
      }
      # JSON syntax can conceal quote characters when conceallevel is enabled.
      {
        event = "FileType";
        pattern = ["json" "jsonc"];
        desc = "Show JSON quotes";
        command = "setlocal conceallevel=0";
      }
      {
        event = "FileType";
        pattern = ["javascript" "javascriptreact" "typescript" "typescriptreact"];
        desc = "Add JS/TS console.log helper";
        command = ''
          lua vim.keymap.set("n", "<leader>cl", function()
            local name = vim.fn.expand("<cword>")
            if name == nil or name == "" then
              return
            end

            local indent = string.rep(" ", vim.fn.indent("."))
            local line = indent .. 'console.log("' .. name .. '", ' .. name .. ');'
            vim.api.nvim_put({ line }, "l", true, true)
          end, { buffer = true, desc = "Insert console.log for symbol" })
        '';
      }
    ];
  };
}
