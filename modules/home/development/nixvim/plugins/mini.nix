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
        ai.enable = true;
        basics.enable = true;
        bracketed.enable = true;
        bufremove.enable = true;
        clue = {
          clues = [
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
          triggers = [
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
        cmdline.enable = true;
        comment.enable = true;
        completion.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        extra.enable = true;
        files.enable = true;
        git.enable = true;
        hipatterns.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        map.enable = true;
        move.enable = true;
        pairs.enable = true;
        pick.enable = true;
        snippets.enable = true;
        splitjoin.enable = true;
        starter = {
          enable = true;
          header = ''
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
          '';
          footer = "";
        };
        surround.enable = true;
        trailspace.enable = true;
      };
    };
  };
}
