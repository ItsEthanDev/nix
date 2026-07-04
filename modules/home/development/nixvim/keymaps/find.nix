{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      # Find
      {
        action = ''<Cmd>Pick history scope="/"<CR>'';
        key = "<space>f/";
        mode = ["n"];
        options = {
          desc = ''"/" history'';
        };
      }
      {
        action = ''<Cmd>Pick history scope=":"<CR>'';
        key = "<space>f:";
        mode = ["n"];
        options = {
          desc = ''":" history'';
        };
      }
      {
        action = ''<Cmd>Pick git_hunks scope="staged"<CR>'';
        key = "<space>fa";
        mode = ["n"];
        options = {
          desc = "Added hunks (all)";
        };
      }
      {
        action = ''<Cmd>Pick git_hunks path="%" scope="staged"<CR>'';
        key = "<space>fA";
        mode = ["n"];
        options = {
          desc = "Added hunks (buf)";
        };
      }
      {
        action = "<Cmd>Pick buffers<CR>";
        key = "<space>fb";
        mode = ["n"];
        options = {
          desc = "Buffers";
        };
      }
      {
        action = "<Cmd>Pick git_commits<CR>";
        key = "<space>fc";
        mode = ["n"];
        options = {
          desc = "Commits (all)";
        };
      }
      {
        action = ''<Cmd>Pick git_commits path="%"<CR>'';
        key = "<space>fC";
        mode = ["n"];
        options = {
          desc = "Commits (buf)";
        };
      }
      {
        action = ''<Cmd>Pick diagnostic scope="all"<CR>'';
        key = "<space>fd";
        mode = ["n"];
        options = {
          desc = "Diagnostic workspace";
        };
      }
      {
        action = ''<Cmd>Pick diagnostic scope="current"<CR>'';
        key = "<space>fD";
        mode = ["n"];
        options = {
          desc = "Diagnostic buffer";
        };
      }
      {
        action = "<Cmd>Pick files<CR>";
        key = "<space>ff";
        mode = ["n"];
        options = {
          desc = "Files";
        };
      }
      {
        action = "<Cmd>Pick grep_live<CR>";
        key = "<space>fg";
        mode = ["n"];
        options = {
          desc = "Grep live";
        };
      }
      {
        action = ''<Cmd>Pick grep pattern="<cword>"<CR>'';
        key = "<space>fG";
        mode = ["n"];
        options = {
          desc = "Grep current word";
        };
      }
      {
        action = "<Cmd>Pick help<CR>";
        key = "<space>fh";
        mode = ["n"];
        options = {
          desc = "Help tags";
        };
      }
      {
        action = "<Cmd>Pick hl_groups<CR>";
        key = "<space>fH";
        mode = ["n"];
        options = {
          desc = "Highlight groups";
        };
      }
      {
        action = ''<Cmd>Pick buf_lines scope="all"<CR>'';
        key = "<space>fl";
        mode = ["n"];
        options = {
          desc = "Lines (all)";
        };
      }
      {
        action = ''<Cmd>Pick buf_lines scope="current"<CR>'';
        key = "<space>fL";
        mode = ["n"];
        options = {
          desc = "Lines (buf)";
        };
      }
      {
        action = "<Cmd>Pick git_hunks<CR>";
        key = "<space>fm";
        mode = ["n"];
        options = {
          desc = "Modified hunks (all)";
        };
      }
      {
        action = ''<Cmd>Pick git_hunks path="%"<CR>'';
        key = "<space>fM";
        mode = ["n"];
        options = {
          desc = "Modified hunks (buf)";
        };
      }
      {
        action = "<Cmd>Pick resume<CR>";
        key = "<space>fr";
        mode = ["n"];
        options = {
          desc = "Resume";
        };
      }
      {
        action = ''<Cmd>Pick visit_paths cwd=""<CR>'';
        key = "<space>fv";
        mode = ["n"];
        options = {
          desc = "Visit paths (all)";
        };
      }
      {
        action = "<Cmd>Pick visit_paths<CR>";
        key = "<space>fV";
        mode = ["n"];
        options = {
          desc = "Visit paths (cwd)";
        };
      }
    ];
  };
}
