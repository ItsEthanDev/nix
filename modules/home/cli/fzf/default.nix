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
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
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
