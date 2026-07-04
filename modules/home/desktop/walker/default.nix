{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.desktop.walker;
in {
  imports = [inputs.walker.homeManagerModules.default];

  options.my.desktop.walker = {
    enable = lib.mkEnableOption "walker configuration";
  };

  config = lib.mkIf cfg.enable {
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
          style = import ./style.nix;
          layouts = {
            "layout" = builtins.readFile ./layout.xml;
          };
        };
      };
    };
  };
}
