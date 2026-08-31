{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.ripgrep];

    programs.nixvim.plugins.mini = {
      enable = lib.mkDefault true;
      mockDevIcons = lib.mkDefault true;
      modules = {
        ai.enable = lib.mkDefault true;
        basics.enable = lib.mkDefault true;
        bracketed.enable = lib.mkDefault true;
        bufremove.enable = lib.mkDefault true;
        clue = {
          clues = lib.mkDefault [
            {
              mode = "n";
              keys = "<Leader>b";
              desc = "+Buffer";
            }
            {
              mode = "n";
              keys = "<Leader>e";
              desc = "+Explore/Edit";
            }
            {
              mode = "n";
              keys = "<Leader>f";
              desc = "+Find";
            }
            {
              mode = "n";
              keys = "<Leader>g";
              desc = "+Git";
            }
            {
              mode = "n";
              keys = "<Leader>l";
              desc = "+Language";
            }
            {
              mode = "n";
              keys = "<Leader>m";
              desc = "+Map";
            }
            {
              mode = "n";
              keys = "<Leader>u";
              desc = "+UI";
            }
            {
              mode = "n";
              keys = "<Leader>z";
              desc = "+Zettelkasten";
            }
            {
              mode = "x";
              keys = "<Leader>g";
              desc = "+Git";
            }
            {
              mode = "x";
              keys = "<Leader>l";
              desc = "+Language";
            }
            {__raw = "require('mini.clue').gen_clues.builtin_completion()";}
            {__raw = "require('mini.clue').gen_clues.g()";}
            {__raw = "require('mini.clue').gen_clues.marks()";}
            {__raw = "require('mini.clue').gen_clues.registers()";}
            {__raw = "require('mini.clue').gen_clues.square_brackets()";}
            {__raw = "require('mini.clue').gen_clues.windows({ submode_resize = true })";}
            {__raw = "require('mini.clue').gen_clues.z()";}
          ];
          triggers = lib.mkDefault [
            {
              mode = ["n" "x"];
              keys = "<Leader>";
            }
            {
              mode = "n";
              keys = "\\";
            }
            {
              mode = ["n" "x"];
              keys = "[";
            }
            {
              mode = ["n" "x"];
              keys = "]";
            }
            {
              mode = "i";
              keys = "<C-x>";
            }
            {
              mode = ["n" "x"];
              keys = "g";
            }
            {
              mode = ["n" "x"];
              keys = "'";
            }
            {
              mode = ["n" "x"];
              keys = "`";
            }
            {
              mode = ["n" "x"];
              keys = ''"'';
            }
            {
              mode = ["i" "c"];
              keys = "<C-r>";
            }
            {
              mode = "n";
              keys = "<C-w>";
            }
            {
              mode = ["n" "x"];
              keys = "s";
            }
            {
              mode = ["n" "x"];
              keys = "z";
            }
          ];
        };
        cmdline.enable = lib.mkDefault true;
        comment.enable = lib.mkDefault true;
        completion.enable = lib.mkDefault true;
        cursorword.enable = lib.mkDefault true;
        diff.enable = lib.mkDefault true;
        extra.enable = lib.mkDefault true;
        files.enable = lib.mkDefault true;
        git.enable = lib.mkDefault true;
        hipatterns.enable = lib.mkDefault true;
        icons.enable = lib.mkDefault true;
        indentscope.enable = lib.mkDefault true;
        map.enable = lib.mkDefault true;
        move.enable = lib.mkDefault true;
        pairs.enable = lib.mkDefault true;
        pick.enable = lib.mkDefault true;
        snippets.enable = lib.mkDefault true;
        splitjoin.enable = lib.mkDefault true;
        starter = {
          enable = lib.mkDefault true;
          header = lib.mkDefault ''
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
          '';
          footer = lib.mkDefault "";
        };
        surround.enable = lib.mkDefault true;
        trailspace.enable = lib.mkDefault true;
      };
    };
  };
}
