{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
  inherit (config.lib.nixvim) mkRaw;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      globals.autoformat = lib.mkDefault true;

      keymaps = [
        {
          key = "<leader>uf";
          mode = "n";
          action = mkRaw ''
            function()
              vim.g.autoformat = not vim.g.autoformat
              vim.notify("Auto Format (Global): " .. (vim.g.autoformat and "On" or "Off"))
            end
          '';
          options = {
            desc = "Toggle Auto Format (Global)";
            silent = true;
          };
        }
        {
          key = "<leader>uF";
          mode = "n";
          action = mkRaw ''
            function()
              local enabled = vim.b.autoformat
              if enabled == nil then
                enabled = vim.g.autoformat ~= false
              end
              vim.b.autoformat = not enabled
              vim.notify("Auto Format (Buffer): " .. (vim.b.autoformat and "On" or "Off"))
            end
          '';
          options = {
            desc = "Toggle Auto Format (Buffer)";
            silent = true;
          };
        }
      ];

      plugins.conform-nvim = {
        autoInstall.enable = lib.mkDefault true;
        enable = lib.mkDefault true;
        settings = {
          format_on_save = lib.mkDefault (mkRaw ''
            function(bufnr)
              if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
                return
              end

              return {
                lsp_format = "fallback",
                timeout_ms = 2000,
                stop_after_first = true,
              }
            end
          '');
          formatters_by_ft = {
            css = lib.mkDefault [
              "oxfmt"
            ];
            html = lib.mkDefault [
              "oxfmt"
            ];
            javascript = lib.mkDefault [
              "oxfmt"
            ];
            javascriptreact = lib.mkDefault [
              "oxfmt"
            ];
            json = lib.mkDefault [
              "oxfmt"
            ];
            jsonc = lib.mkDefault [
              "oxfmt"
            ];
            nix = lib.mkDefault [
              "alejandra"
            ];
            python = lib.mkDefault [
              "black"
            ];
            rust = lib.mkDefault [
              "rustfmt"
            ];
            typescript = lib.mkDefault [
              "oxfmt"
            ];
            typescriptreact = lib.mkDefault [
              "oxfmt"
            ];
          };
          notify_on_error = lib.mkDefault false;
          notify_no_formatters = lib.mkDefault false;
        };
      };
    };
  };
}
