{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.gitShortcuts;
  aliases = {
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
  options.my.cli.gitShortcuts.enable = lib.mkEnableOption "Git shell shortcuts for Fish and Zsh";

  config = lib.mkIf cfg.enable {
    programs = {
      fish.shellAbbrs = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
