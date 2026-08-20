{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins = {
      lsp = {
        enable = lib.mkDefault true;
        servers = {
          # CSS
          cssls.enable = true;
          # JSON
          jsonnet_ls.enable = true;
          # Nix
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import ${pkgs.path} { }";
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
          tsgo.enable = true;
        };
      };
    };
  };
}
