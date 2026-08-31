{
  lib,
  pkgs,
  ...
}: {
  home = {
    stateVersion = "24.05";
    username = lib.mkForce "ethan";
    homeDirectory = lib.mkForce "/Users/ethan";
    packages = with pkgs; [
      bun
      cargo
      discord
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
    development = {
      enable = true;
      git = {
        email = "newton@itsEthan.dev";
        name = "Ethan Brady";
      };
    };
    terminal.enable = true;
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };
}
