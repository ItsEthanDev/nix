{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

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
      hunk
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
    herdr.enable = true;
    home-manager.enable = true;
    lazygit.enable = true;
    pi-coding-agent.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
    fonts.sizes.terminal = 16;
  };
}
