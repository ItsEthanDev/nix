{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development.opencode;
in {
  options.my.development.opencode.enable = lib.mkEnableOption "opencode configuration";

  config = lib.mkIf cfg.enable {
    home.packages = lib.optionals pkgs.stdenv.isLinux [pkgs.libnotify];

    programs.opencode = {
      enable = lib.mkDefault true;

      commands = lib.mkDefault ./commands;
      skills = lib.mkDefault ./skills;

      context = lib.mkDefault (builtins.readFile ./context.md);

      settings = {
        plugin = ["@mohak34/opencode-notifier@latest"];
        permission = {
          external_directory."/nix/store/**" = lib.mkDefault "allow";
          read."/nix/store/**" = lib.mkDefault "allow";
          skill.customize-opencode = lib.mkDefault "deny";
          task.commit = lib.mkDefault "deny";
        };
        agent.build.permission.bash = {
          sudo = lib.mkDefault "ask";
          "sudo *" = lib.mkDefault "ask";
        };
      };

      tui = {
        "$schema" = lib.mkDefault "https://opencode.ai/tui.json";
        theme = lib.mkDefault "system";
      };
    };
  };
}
