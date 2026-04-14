_: {
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        experimental.ghost_text = true;
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "path";}
        ];
      };
    };
    lsp = {
      enable = true;
      servers = {
        jsonnet_ls.enable = true;
        nixd = {
          enable = true;
          settings = {
            nixpkgs.expr = "import <nixpkgs> { }";
          };
        };
        rust_analyzer.enable = true;
        tailwindcss.enable = true;
        tsgo.enable = true;
      };
    };
  };
}
