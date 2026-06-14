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
        # Background
        background-opacity = lib.mkIf isDarwin 0.875;
        # Copy
        copy-on-select = true;
        selection-clear-on-copy = true;
        # Font
        font-family = "JetBrainsMono NFM Regular";
        font-size = 16;
        # Shell
        # Will check to make sure fish is installed before setting the shell to
        # fish. The follow must be set in nixos/darwin modules
        # {
        #   programs.fish.enable = true;
        #   environment.shells = [pkgs.fish];
        # }
        command = lib.mkIf hasFish (lib.getExe pkgs.fish);
        shell-integration = lib.mkIf hasFish "fish";
        # Quick Terminal
        quick-terminal-position = "center";
        quick-terminal-size = "90%,90%";
        # Window Padding Padding
        window-padding-color = "extend";
        window-padding-x =
          if isDarwin
          then 8
          else 4;
        # Window Save State
        window-save-state = "always";
      };
    };
  };
}
