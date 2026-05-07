_: {
  programs.nixvim.plugins = {
    blink-cmp-copilot.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion = {
          enabled = false;
          hide_during_completion = true;
        };
        nes = {
          enabled = true;
          auto_trigger = true;
          keymap = {
            accept = false;
            accept_and_goto = false;
            dismiss = false;
          };
        };
      };
    };

    copilot-lsp = {
      enable = true;
      settings.nes.move_count_threshold = 3;
      luaConfig.post = ''
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
      '';
    };
  };
}
