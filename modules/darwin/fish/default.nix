{
  config,
  lib,
  ...
}: let
  cfg = config.my.fish;
in {
  options.my.fish.enable = lib.mkEnableOption "Fish system configuration";

  config = lib.mkIf cfg.enable {
    programs.fish.enable = lib.mkDefault true;
    environment.shells = [config.programs.fish.package];
  };
}
