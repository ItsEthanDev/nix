{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
  inherit (config.lib.nixvim) mkRaw;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.zk = {
        enable = lib.mkDefault true;
        settings = {
          lsp = {
            auto_attach = {
              enabled = true;
              filetypes = [
                "markdown"
              ];
            };
            config = {
              cmd = [
                "zk"
                "lsp"
              ];
              name = "zk";
            };
          };
          picker = "telescope";
        };
      };

      keymaps = [
        {
          key = "gx";
          action = "<Cmd>normal! gx<CR>";
          mode = "n";
          options = {
            desc = "Open Link";
            silent = true;
          };
        }
        {
          key = "<leader>zn";
          action = mkRaw ''
            function()
              require("zk").new({ title = vim.fn.input("Title: ") })
            end
          '';
          mode = "n";
          options = {
            desc = "New Note";
            silent = true;
          };
        }
        {
          key = "<leader>zz";
          action = "<Cmd>ZkNotes { sort = { 'modified' } }<CR>";
          mode = "n";
          options = {
            desc = "Notes Picker";
            silent = true;
          };
        }
        {
          key = "<leader>zf";
          action = mkRaw ''
            function()
              require("zk").edit({
                sort = { "modified" },
                match = { vim.fn.input("Search: ") },
              }, { title = "Zk Notes" })
            end
          '';
          mode = "n";
          options = {
            desc = "Search Notes";
            silent = true;
          };
        }
        {
          key = "<leader>zt";
          action = "<Cmd>ZkTags<CR>";
          mode = "n";
          options = {
            desc = "Tags Picker";
            silent = true;
          };
        }
        {
          key = "<leader>zi";
          action = "<Cmd>ZkLinks<CR>";
          mode = "n";
          options = {
            desc = "Outbound Links";
            silent = true;
          };
        }
        {
          key = "<leader>zo";
          action = "<Cmd>ZkBacklinks<CR>";
          mode = "n";
          options = {
            desc = "Backlinks";
            silent = true;
          };
        }
        {
          key = "<leader>zl";
          action = "<Cmd>ZkInsertLink<CR>";
          mode = "n";
          options = {
            desc = "Insert Link";
            silent = true;
          };
        }
        {
          key = "<leader>zl";
          action = mkRaw ''
            function()
              vim.cmd("'<,'>ZkInsertLinkAtSelection { matchSelected = true }")
            end
          '';
          mode = "v";
          options = {
            desc = "Link Selection";
            silent = true;
          };
        }
        {
          key = "<leader>znt";
          action = mkRaw ''
            function()
              vim.cmd("'<,'>ZkNewFromTitleSelection")
            end
          '';
          mode = "v";
          options = {
            desc = "New Note From Title";
            silent = true;
          };
        }
        {
          key = "<leader>znc";
          action = mkRaw ''
            function()
              vim.cmd("'<,'>ZkNewFromContentSelection { title = vim.fn.input('Title: ') }")
            end
          '';
          mode = "v";
          options = {
            desc = "New Note From Content";
            silent = true;
          };
        }
      ];
    };
  };
}
