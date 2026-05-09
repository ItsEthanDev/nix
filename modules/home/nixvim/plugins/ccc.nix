_: {
  programs.nixvim = {
    plugins.ccc = {
      enable = true;
      settings = {
        highlighter = {
          auto_enable = true;
          filetypes = [
            "css"
            "scss"
            "sass"
            "less"
          ];
          lsp = true;
        };

        inputs = [
          "ccc.input.rgb"
          "ccc.input.hsl"
          "ccc.input.lab"
          "ccc.input.lch"
          "ccc.input.oklab"
          "ccc.input.oklch"
        ];

        outputs = [
          "ccc.output.hex"
          "ccc.output.css_rgb"
          "ccc.output.css_hsl"
          "ccc.output.css_lab"
          "ccc.output.css_lch"
          "ccc.output.css_oklab"
          "ccc.output.css_oklch"
        ];

        recognize = {
          input = true;
          output = true;
        };
      };
    };

    keymaps = [
      {
        action = "<cmd>CccPick<CR>";
        key = "<leader>cp";
        mode = ["n" "x"];
        options.desc = "Pick color under cursor";
      }
      {
        action = "<cmd>CccHighlighterToggle<CR>";
        key = "<leader>ch";
        mode = "n";
        options.desc = "Toggle color highlighter";
      }
    ];
  };
}
