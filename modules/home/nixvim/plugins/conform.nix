{pkgs, ...}: {
  home.packages = with pkgs; [
    biome
    rustfmt
    alejandra
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 2000;
        stop_after_first = true;
      };
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
}
