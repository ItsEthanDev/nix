{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.git;
in {
  options.my.development.git = {
    enable = lib.mkEnableOption "git configuration";
    email = lib.mkOption {
      type = lib.types.str;
      description = "The email address to use for git commits";
    };
    name = lib.mkOption {
      type = lib.types.str;
      description = "The name to use for git commits";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = lib.mkDefault true;
        lfs = {
          enable = lib.mkDefault true;
        };
        settings = lib.mapAttrsRecursive (_: value: lib.mkDefault value) {
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
        enable = lib.mkDefault true;
        enableGitIntegration = lib.mkDefault true;
        options = {
          side-by-side = lib.mkDefault true;
        };
      };
    };
  };
}
