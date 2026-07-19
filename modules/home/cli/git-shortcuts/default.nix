{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.git-shortcuts;
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
  options.my.cli.git-shortcuts.enable = lib.mkEnableOption "Git shell shortcuts";

  config = lib.mkIf cfg.enable {
    programs = {
      fish.shellAbbrs = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
