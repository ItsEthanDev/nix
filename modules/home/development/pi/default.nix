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
      extraPackages = [pkgs.nodejs];
      settings = {
        defaultProvider = "openai-codex";
        defaultModel = "gpt-5.6-sol";
        packages = [
          "npm:pi-web-access"
        ];
        skills = [
          ../../../../static/ai/skills
        ];
      };
    };
  };
}
