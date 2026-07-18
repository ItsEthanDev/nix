{
  config,
  lib,
  ...
}: let
  cfg = config.my.homebrew;
in {
  options.my.homebrew.enable = lib.mkEnableOption "Homebrew integration";

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
    };
  };
}
