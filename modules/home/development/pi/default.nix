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
      keybindings = {
        "app.model.cycleForward" = [];
        "tui.select.down" = ["down" "ctrl+n"];
        "tui.select.up" = ["up" "ctrl+p"];
      };
      settings = {
        branchSummary.skipPrompt = true;
        defaultProvider = "openai-codex";
        defaultModel = "gpt-5.6-sol";
        enabledModels = ["openai-codex/gpt-5.6-*"];
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
