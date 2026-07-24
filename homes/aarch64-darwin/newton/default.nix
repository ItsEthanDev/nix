{
  lib,
  pkgs,
  ...
}: {
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "frappe";
    zsh-syntax-highlighting = {
      enable = false;
    };
  };

  home = {
    stateVersion = "24.05";
    username = lib.mkForce "ethan";
    homeDirectory = lib.mkForce "/Users/ethan";
    packages = with pkgs; [
      biome
      bun
      cargo
      discord
      fastfetch
      fd
      gh
      jq
      nodejs
      pnpm
      ripgrep
      rustc
      tlrc
      unzip
      zip
      zk
    ];
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
      fish = {
        enable = true;
        listOnDirectoryChange = true;
      };
      starship.enable = true;
      zellij.enable = true;
      zsh.enable = true;
    };
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
