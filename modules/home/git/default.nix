{
  config,
  lib,
  ...
}: {
  options.itsEthan.cli.git = {
    email = lib.mkOption {
      type = lib.types.str;
      default = "git@ethanbrady.xyz";
      description = "The email address to use for git commits";
    };
    name = lib.mkOption {
      type = lib.types.str;
      default = "EthanJ-Brady";
      description = "The name to use for git commits";
    };
  };

  config = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = config.itsEthan.cli.git.email;
          name = config.itsEthan.cli.git.name;
        };
        alias = {
          last = "log -1 HEAD";
        };
        advice = {
          skippedCherryPicks = false;
        };
        core = {
          compression = 9;
          whitespace = "error";
          preloadindex = true;
        };
        init = {
          defaultBranch = "main";
        };
        log = {
          abbrevCommit = true;
        };
        pull = {
          default = "current";
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
          default = "current";
          followTags = true;
        };
        rebase = {
          autostash = true;
          missingCommitsCheck = "warn";
        };
        status = {
          branch = true;
          showStash = true;
          showUntrackedFiles = "all";
        };
        "url \"git@github.com:EthanJ-Brady/\"" = {
          insteadOf = "me:";
        };
      };
    };

    programs.zsh.shellAliases = {
      gd = "git diff";
      ga = "git add";
      gap = "git add -p";
      gc = "git commit";
      gp = "git push";
      gu = "git pull";
      gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'";
      gs = "git status -s";
      gcl = "git clone";
    };
  };
}
