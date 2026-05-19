{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim.plugins = {
    # actions-preview = {
    #   enable = true;
    #   settings = {
    #     backend = ["telescope"];
    #     telescope = mkRaw ''
    #       vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {
    #         sorting_strategy = "ascending",
    #         layout_strategy = "vertical",
    #         layout_config = {
    #           width = 0.8,
    #           height = 0.9,
    #           prompt_position = "top",
    #           preview_cutoff = 20,
    #           preview_height = function(_, _, max_lines)
    #             return max_lines - 15
    #           end,
    #         },
    #       })
    #     '';
    #   };
    # };

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
