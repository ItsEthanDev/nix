{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  home.packages = with pkgs; [
    biome
    rustfmt
    alejandra
  ];

  programs.nixvim = {
    globals.autoformat = true;

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
      enable = true;
      settings = {
        format_on_save = mkRaw ''
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
        '';
        formatters_by_ft = {
          javascript = [
            "biome"
          ];
          javascriptreact = [
            "biome"
          ];
          json = [
            "biome"
          ];
          markdown = [
            "biome"
          ];
          nix = [
            "alejandra"
          ];
          python = [
            "black"
          ];
          rust = [
            "rustfmt"
          ];
          typescript = [
            "biome"
          ];
          typescriptreact = [
            "biome"
          ];
        };
        notify_on_error = false;
        notify_no_formatters = false;
      };
    };
  };
}
