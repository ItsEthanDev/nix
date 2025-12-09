{
  pkgs,
  config,
  lib,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
in
{
  options.itsEthan.shell.ghostty = {
    enable = lib.mkEnableOption "Enables the terminal emulator ghostty and the configuration";
  };

  config = lib.mkIf config.itsEthan.shell.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf isDarwin ghostty-mock;
      enableZshIntegration = true;
      installBatSyntax = true;
      settings = {
        font-family = "JetBrainsMono NFM Regular";
        font-size = 19;
        theme = "Catppuccin Frappe";
        window-padding-color = "extend";
        window-padding-x = 4;
      };
    };
  };
}
