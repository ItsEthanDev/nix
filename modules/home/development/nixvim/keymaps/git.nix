{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      # Git
      {
        action = "<Cmd>Git diff --cached<CR>";
        key = "<space>ga";
        mode = ["n"];
        options = {
          desc = "Added diff";
        };
      }
      {
        action = "<Cmd>Git diff --cached -- %<CR>";
        key = "<space>gA";
        mode = ["n"];
        options = {
          desc = "Added diff buffer";
        };
      }
      {
        action = "<Cmd>Git commit<CR>";
        key = "<space>gc";
        mode = ["n"];
        options = {
          desc = "Commit";
        };
      }
      {
        action = "<Cmd>Git commit --amend<CR>";
        key = "<space>gC";
        mode = ["n"];
        options = {
          desc = "Commit amend";
        };
      }
      {
        action = "<Cmd>Git diff<CR>";
        key = "<space>gd";
        mode = ["n"];
        options = {
          desc = "Diff";
        };
      }
      {
        action = "<Cmd>Git diff -- %<CR>";
        key = "<space>gD";
        mode = ["n"];
        options = {
          desc = "Diff buffer";
        };
      }
      {
        action = "<Cmd>Git log --oneline --decorate --graph --all<CR>";
        key = "<space>gl";
        mode = ["n"];
        options = {
          desc = "Log";
        };
      }
      {
        action = "<Cmd>Git log --oneline --decorate --graph --follow -- %<CR>";
        key = "<space>gL";
        mode = ["n"];
        options = {
          desc = "Log buffer";
        };
      }
      {
        action = "<Cmd>lua MiniDiff.toggle_overlay()<CR>";
        key = "<space>go";
        mode = ["n"];
        options = {
          desc = "Toggle overlay";
        };
      }
      {
        action = "<Cmd>lua MiniGit.show_at_cursor()<CR>";
        key = "<space>gs";
        mode = ["n"];
        options = {
          desc = "Show at cursor";
        };
      }
      {
        action = "<Cmd>lua MiniGit.show_at_cursor()<CR>";
        key = "<space>gs";
        mode = ["x"];
        options = {
          desc = "Show at selection";
        };
      }
    ];
  };
}
