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
  options = {
    my = {
      terminal = {
        font-size = lib.mkOption {
          type = lib.types.int;
          default = 18;
          description = "Font size for terminals.";
        };

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
        # Will check to make sure fish is installed before setting the shell to
        # fish. The follow must be set in nixos/darwin modules
        # {
        #   programs.fish.enable = true;
        #   environment.shells = [pkgs.fish];
        # }
        command = lib.mkIf hasFish (lib.getExe pkgs.fish);
        confirm-close-surface = false;
        font-family = "JetBrainsMono NFM Regular";
        font-size = 18;
        window-padding-color = "extend";
        window-padding-x = 4;
      };
    };
  };
}
