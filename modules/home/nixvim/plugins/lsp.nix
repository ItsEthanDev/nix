_: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        # CSS
        cssls.enable = true;
        # JSON
        jsonnet_ls.enable = true;
        # Nix
        nixd = {
          enable = true;
          config = {
            nixpkgs.expr = "import <nixpkgs> { }";
          };
        };
        # Rust
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        # Tailwind
        tailwindcss.enable = true;
        # Typescript
        ts_ls.enable = true;
      };
    };
  };
}
