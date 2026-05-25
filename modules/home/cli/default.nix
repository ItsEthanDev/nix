{pkgs, ...}: let
  shellAliases = {
    cat = "bat";
    cd = "z";
    ls = "eza --icons=always";
    ll = "eza -lh";
    l = "eza -lah";
    tree = "eza -T";
  };
in {
  home.packages = with pkgs; [
    unzip
    zip
    tlrc
    fastfetch
    ripgrep
    fd
    jless
    jq
    zk
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      fileWidgetOptions = [
        "-i"
        "-e"
      ];
      historyWidgetOptions = [
        "-i"
        "-e"
      ];
    };
    lazygit.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    fish.shellAliases = shellAliases;
    zsh.shellAliases = shellAliases;
  };
}
