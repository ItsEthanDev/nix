{
  config,
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
  hasFish = config.programs.fish.enable;
in {
  options = {
    my.terminal.command = lib.mkOption {
      type = lib.types.str;
      description = "Command-line string used to launch an app in my terminal.";
    };
  };

  config = {
    my.terminal.command = lib.mkDefault "ghostty -e";
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
        command = lib.mkIf hasFish "${pkgs.fish}/bin/fish";
        confirm-close-surface = false;
        font-family = "JetBrainsMono NFM Regular";
        font-size = 18;
        window-padding-color = "extend";
        window-padding-x = 4;
      };
    };
  };
}
