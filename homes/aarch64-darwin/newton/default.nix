{lib, ...}: {
  home = {
    stateVersion = "24.05";
    username = lib.mkForce "ethan";
    homeDirectory = lib.mkForce "/Users/ethan";
  };
  my = {
    cli = {
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      zoxide.enable = true;
    };
    development = {
      git.enable = true;
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
