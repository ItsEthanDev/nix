{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      # LSP
      {
        action = "<Cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<space>la";
        mode = ["n"];
        options = {
          desc = "Actions";
        };
      }
      {
        action = "<Cmd>lua vim.diagnostic.open_float()<CR>";
        key = "<space>ld";
        mode = ["n"];
        options = {
          desc = "Diagnostic popup";
        };
      }
      {
        action = ''<Cmd>lua require("conform").format()<CR>'';
        key = "<space>lf";
        mode = ["n"];
        options = {
          desc = "Format";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.implementation()<CR>";
        key = "<space>li";
        mode = ["n"];
        options = {
          desc = "Implementation";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.hover()<CR>";
        key = "<space>lh";
        mode = ["n"];
        options = {
          desc = "Hover";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.codelens.run()<CR>";
        key = "<space>ll";
        mode = ["n"];
        options = {
          desc = "Lens";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.rename()<CR>";
        key = "<space>lr";
        mode = ["n"];
        options = {
          desc = "Rename";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.references()<CR>";
        key = "<space>lR";
        mode = ["n"];
        options = {
          desc = "References";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.definition()<CR>";
        key = "<space>ls";
        mode = ["n"];
        options = {
          desc = "Source definition";
        };
      }
      {
        action = "<Cmd>lua vim.lsp.buf.type_definition()<CR>";
        key = "<space>lt";
        mode = ["n"];
        options = {
          desc = "Type definition";
        };
      }
    ];
  };
}
