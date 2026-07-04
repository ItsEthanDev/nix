{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.opencode;
in {
  options.my.development.opencode.enable = lib.mkEnableOption "opencode configuration";

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;

      agents = ./agents;
      commands = ./commands;
      skills = ./skills;

      context = builtins.readFile ./context.md;

      settings.permission.task.commit = "deny";

      tui = {
        "$schema" = "https://opencode.ai/tui.json";
        theme = lib.mkForce "system";
      };

      web = {
        enable = true;
        environmentFile = "/home/ethan/.config/opencode/web.env";
        extraArgs = ["--mdns"];
      };
    };
  };
}
