{
  lib,
  pkgs,
  ...
}: {
  home = {
    stateVersion = "24.05";
    username = lib.mkForce "ethan";
    homeDirectory = lib.mkForce "/Users/ethan";
    packages = [pkgs.gh];
  };
  my = {
    cli = {
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      gitShortcuts.enable = true;
      zoxide.enable = true;
    };
    development = {
      git = {
        enable = true;
        email = "newton@itsEthan.dev";
        name = "Ethan Brady";
      };
      nixvim.enable = true;
      opencode.enable = true;
    };
    remote.ssh.enable = true;
    terminal = {
      fish.enable = true;
      starship.enable = true;
      zellij.enable = true;
      zsh.enable = true;
    };
  };
  programs.home-manager.enable = true;
}
