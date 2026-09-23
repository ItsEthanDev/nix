{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
  webAccessExtension = "${config.home.homeDirectory}/.pi/agent/npm/node_modules/pi-web-access/index.ts";
  withWebAccess = path:
    builtins.replaceStrings ["@PI_WEB_ACCESS_EXTENSION@"] [webAccessExtension] (builtins.readFile path);
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
        defaultModel = lib.mkDefault "gpt-6-sol";
        defaultThinkingLevel = lib.mkDefault "medium";
        enabledModels = lib.mkDefault [
          "openai-codex/gpt-6-sol"
          "openai-codex/gpt-5.6-terra"
          "openai-codex/gpt-5.6-luna"
          "openai-codex/gpt-6-astra"
        ];
        packages = [
          "npm:pi-web-access"
          {
            source = "npm:pi-subagents";
            prompts = [];
            skills = [];
          }
        ];
        skills = [
          ../../../static/ai/skills
        ];
        subagents.disableBuiltins = lib.mkDefault true;
      };
    };

    home.file = {
      ".pi/agent/AGENTS.md".source = ../../../static/ai/AGENTS.md;
      ".pi/agent/extensions/subagent/config.json".text = builtins.toJSON {maxSubagentDepth = 2;};
      ".pi/agent/agents/delegate.md".text = withWebAccess ../../../static/ai/agents/delegate.md;
      ".pi/agent/agents/researcher.md".text = withWebAccess ../../../static/ai/agents/researcher.md;
      ".pi/agent/agents/reviewer.md".text = withWebAccess ../../../static/ai/agents/reviewer.md;
      ".pi/agent/agents/scout.md".source = ../../../static/ai/agents/scout.md;
      ".pi/agent/agents/worker.md".source = ../../../static/ai/agents/worker.md;
    };
  };
}
