{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.terminal.ghostty;
  inherit (pkgs.stdenv) isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
  hasFish = config.programs.fish.enable;
in {
  imports = [
    ./keybind.nix
  ];

  options.my.terminal.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = lib.mkDefault true;

      # The Darwin implementation doesn't work here, so we use a mock instead if
      # we are on a darwin system.
      package = lib.mkIf isDarwin (lib.mkDefault ghostty-mock);

      # Integrations
      enableZshIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      installBatSyntax = lib.mkDefault true;

      settings = {
        # Background
        background-opacity = lib.mkIf isDarwin (lib.mkDefault 0.875);
        # Copy
        copy-on-select = lib.mkDefault true;
        selection-clear-on-copy = lib.mkDefault true;
        # Font
        font-family = lib.mkDefault "JetBrainsMono NFM Regular";
        font-size = lib.mkDefault 16;
        # Shell
        command = lib.mkIf hasFish (lib.mkDefault (lib.getExe pkgs.fish));
        shell-integration = lib.mkIf hasFish (lib.mkDefault "fish");
        # Quick Terminal
        quick-terminal-position = lib.mkDefault "center";
        quick-terminal-size = lib.mkDefault "90%,90%";
        # Window Padding Padding
        window-padding-color = lib.mkDefault "extend";
        window-padding-x =
          if isDarwin
          then lib.mkDefault 8
          else lib.mkDefault 4;
        # Window Save State
        window-save-state = lib.mkDefault "always";
      };
    };
  };
}
