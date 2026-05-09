{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    plugins.gitsigns.enable = true;

    keymaps = [
      {
        action = mkRaw ''
          function()
            if vim.wo.diff then
              vim.cmd.normal({"]c", bang = true})
            else
              require("gitsigns").nav_hunk("next")
            end
          end
        '';
        key = "]c";
        mode = "n";
        options = {
          desc = "Next Git Change";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            if vim.wo.diff then
              vim.cmd.normal({"[c", bang = true})
            else
              require("gitsigns").nav_hunk("prev")
            end
          end
        '';
        key = "[c";
        mode = "n";
        options = {
          desc = "Prev Git Change";
          silent = true;
        };
      }
      {
        action = mkRaw "require('gitsigns').preview_hunk";
        key = "do";
        mode = "n";
        options = {
          desc = "Preview Git Hunk";
          silent = true;
        };
      }
      {
        action = mkRaw "require('gitsigns').stage_hunk";
        key = "du";
        mode = "n";
        options = {
          desc = "Stage Git Hunk";
          silent = true;
        };
      }
      {
        action = mkRaw "require('gitsigns').undo_stage_hunk";
        key = "dU";
        mode = "n";
        options = {
          desc = "Unstage Git Hunk";
          silent = true;
        };
      }
      {
        action = mkRaw "require('gitsigns').reset_hunk";
        key = "dp";
        mode = "n";
        options = {
          desc = "Restore Git Hunk";
          silent = true;
        };
      }
    ];
  };
}
