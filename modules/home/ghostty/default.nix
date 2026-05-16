{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
  hasFish = config.programs.fish.enable;
in {
  imports = [
    ./keybind.nix
  ];

  options = {
    my = {
      terminal = {
        launch = lib.mkOption {
          type = lib.types.str;
          default = "ghostty";
          description = "Command to launch a plain terminal.";
        };

        exec = lib.mkOption {
          type = lib.types.str;
          default = "ghostty -e";
          description = "Command prefix used to run other commands inside the terminal.";
        };

        execWithTitle = lib.mkOption {
          type = lib.types.functionTo lib.types.str;
          default = title: "${config.my.terminal.launch} --title=${lib.escapeShellArg title} -e";
          description = "Command prefix used to run commands inside the terminal with a custom title.";
        };
      };
    };
  };

  config = {
    programs.ghostty = {
      enable = true;

      # The Darwin implementation doesn't work here, so we use a mock instead if
      # we are on a darwin system.
      package = lib.mkIf isDarwin ghostty-mock;

      # Integrations
      enableZshIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;

      settings = {
        background-opacity = lib.mkIf isDarwin 0.875;
        # Will check to make sure fish is installed before setting the shell to
        # fish. The follow must be set in nixos/darwin modules
        # {
        #   programs.fish.enable = true;
        #   environment.shells = [pkgs.fish];
        # }
        command = lib.mkIf hasFish (lib.getExe pkgs.fish);
        copy-on-select = true;
        confirm-close-surface = false;
        font-family = "JetBrainsMono NFM Regular";
        font-size = 16;
        shell-integration = lib.mkIf hasFish "fish";
        quick-terminal-position = "center";
        quick-terminal-size = "90%,90%";
        window-padding-color = "extend";
        window-padding-x =
          if isDarwin
          then 8
          else 4;
        window-save-state = "always";
      };
    };
  };
}
