{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development.pi;
in {
  options.my.development.pi.enable = lib.mkEnableOption "pi configuration";

  config = lib.mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = true;
      settings.skills = [
        ../../../../static/skills
      ];
    };
  };
}
