{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
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
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
            };
          };
          # Rust
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
            settings = {
              cargo = {
                targetDir = "target/rust-analyzer";
              };
            };
          };
          # Tailwind
          tailwindcss.enable = true;
          # Typescript
          ts_ls.enable = true;
        };
      };
    };
  };
}
