{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.my.development.git;
  gitAliases = {
    gd = "git diff";
    ga = "git add";
    gap = "git add -p";
    gc = "git commit";
    gp = "git push";
    gu = "git pull";
    gl = "git log --all --graph";
    gs = "git status -s";
    gcl = "git clone";
  };
in {
  options.my.development.git = {
    enable = lib.mkEnableOption "git configuration";
    email = lib.mkOption {
      type = lib.types.str;
      default = "${osConfig.networking.hostName}@itsEthan.dev";
      description = "The email address to use for git commits";
    };
    name = lib.mkOption {
      type = lib.types.str;
      default = "Ethan Brady";
      description = "The name to use for git commits";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs = {
          enable = true;
        };
        settings = {
          user = {
            inherit (cfg) email name;
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
          format = {
            pretty = "format:%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n";
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
          "url \"git@github.com:ItsEthanDev/\"" = {
            insteadOf = "me:";
          };
        };
      };

      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          side-by-side = true;
        };
      };

      zsh.shellAliases = gitAliases;
      fish.shellAbbrs = gitAliases;
    };

    home.packages = with pkgs; [
      gh
    ];
  };
}
