{inputs, ...}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      theme = "my-theme";
      force_keyboard_focus = true;
      selection_wrap = true;
      hide_action_hints = true;
      placeholders.default = {
        input = "Search";
        list = "";
      };
      columns = {
        symbols = 1;
      };
      providers = {
        default = ["desktopapplications"];
        empty = [];
        max_results = 256;
      };
      providers.prefixes = [
        {
          prefix = "/";
          provider = "providerlist";
        }
        {
          prefix = ".";
          provider = "files";
        }
        {
          prefix = ":";
          provider = "symbols";
        }
        {
          prefix = "=";
          provider = "calc";
        }
        {
          prefix = "@";
          provider = "websearch";
        }
        {
          prefix = "$";
          provider = "clipboard";
        }
      ];
      keybinds = {
        next = ["ctrl n"];
        previous = ["ctrl p"];
      };
    };

    themes = {
      "my-theme" = {
        style = builtins.readFile ./style.css;
        layouts = {
          "layout" = builtins.readFile ./layout.xml;
        };
      };
    };
  };
}
