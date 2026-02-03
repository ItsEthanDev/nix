{inputs, ...}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      theme = "my-theme";
      hide_action_hints = true;
      placeholders.default = {
        input = "Search";
        list = "No Results";
      };
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = "_";
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
