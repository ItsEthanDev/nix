{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = lib.mkDefault true;
      extraPackages = [pkgs.nodejs];
      keybindings = {
        "app.model.cycleForward" = [];
        "tui.select.down" = ["down" "ctrl+n"];
        "tui.select.up" = ["up" "ctrl+p"];
      };
      settings = {
        branchSummary.skipPrompt = lib.mkDefault true;
        defaultProvider = lib.mkDefault "openai-codex";
        defaultModel = lib.mkDefault "gpt-5.6-sol";
        enabledModels = ["openai-codex/gpt-5.6-*"];
        packages = [
          "npm:pi-web-access"
        ];
        skills = [
          ../../../static/ai/skills
        ];
      };
    };
  };
}
