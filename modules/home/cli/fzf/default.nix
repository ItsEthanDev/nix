{
  config,
  lib,
  ...
}: let
  cfg = config.my.cli.fzf;
in {
  options.my.cli.fzf.enable = lib.mkEnableOption "fzf configuration";

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      fileWidgetOptions = [
        "-i"
        "-e"
      ];
      historyWidgetOptions = [
        "-i"
        "-e"
      ];
    };
  };
}
