{
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
in {
  programs.ghostty = {
    enable = true;
    package = lib.mkIf isDarwin ghostty-mock;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    settings = {
      font-family = "JetBrainsMono NFM Regular";
      font-size = 19;
      theme = "Catppuccin Mocha";
      window-padding-color = "extend";
      window-padding-x = 4;
    };
  };
}
