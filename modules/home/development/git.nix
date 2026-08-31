{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs = {
      fish.shellAbbrs = {
        ga = "git add";
        gap = "git add -p";
        gc = "git commit";
        gcl = "git clone";
        gd = "git diff";
        gl = "git log --all --graph";
        gp = "git push";
        gs = "git status -s";
        gu = "git pull";
      };

      git = {
        enable = lib.mkDefault true;
        lfs.enable = lib.mkDefault true;
        settings = {
          advice.skippedCherryPicks = lib.mkDefault false;
          alias.last = lib.mkDefault "log -1 HEAD";
          format.pretty = lib.mkDefault "format:%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n";
          init.defaultBranch = lib.mkDefault "main";
          pull.rebase = lib.mkDefault true;
          push = {
            autoSetupRemote = lib.mkDefault true;
            default = lib.mkDefault "current";
            followTags = lib.mkDefault true;
          };
          rebase = {
            autostash = lib.mkDefault true;
            missingCommitsCheck = lib.mkDefault "warn";
          };
          status = {
            branch = lib.mkDefault true;
            showStash = lib.mkDefault true;
          };
          user = {
            email = lib.mkDefault cfg.git.email;
            name = lib.mkDefault cfg.git.name;
          };
        };
      };
    };
  };
}
