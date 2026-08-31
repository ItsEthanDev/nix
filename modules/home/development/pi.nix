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
        "app.model.cycleForward" = lib.mkDefault [];
        "tui.select.down" = lib.mkDefault ["down" "ctrl+n"];
        "tui.select.up" = lib.mkDefault ["up" "ctrl+p"];
      };
      settings = {
        branchSummary.skipPrompt = lib.mkDefault true;
        defaultProvider = lib.mkDefault "openai-codex";
        defaultModel = lib.mkDefault "gpt-5.6-sol";
        enabledModels = lib.mkDefault ["openai-codex/gpt-5.6-*"];
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
