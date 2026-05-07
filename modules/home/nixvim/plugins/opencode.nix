{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    plugins.opencode = {
      enable = true;
      autoLoad = true;
    };

    keymaps = [
      {
        action = mkRaw ''
          function()
            require("opencode").ask("@this: ", { submit = true })
          end
        '';
        key = "<C-a>";
        mode = "n";
        options = {
          desc = "Ask OpenCode About Thing";
          silent = true;
        };
      }
      {
        action = mkRaw ''
          function()
            require("opencode").toggle()
          end
        '';
        key = "<C-.>";
        mode = ["n" "t"];
        options = {
          desc = "Toggle OpenCode UI";
          silent = true;
        };
      }
    ];
  };
}
