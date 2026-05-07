{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = mkRaw ''
        {
          preset = "default",
          ["<C-y>"] = {
            function(cmp)
              if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                cmp.hide()
                return (
                  require("copilot-lsp.nes").apply_pending_nes()
                  and require("copilot-lsp.nes").walk_cursor_end_edit()
                )
              end
              if cmp.snippet_active() then
                return cmp.accept()
              end
              return cmp.select_and_accept()
            end,
            "snippet_forward",
            "fallback",
          },
        }
      '';
      sources = {
        default = [
          "lsp"
          "path"
          "buffer"
          "copilot"
        ];
        providers.copilot = {
          name = "copilot";
          module = "blink-cmp-copilot";
          async = true;
          score_offset = 100;
        };
      };
    };
  };
}
