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
  ];

  programs = {
    bat.enable = true;
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    fish.shellAliases = shellAliases;
    zsh.shellAliases = shellAliases;
  };
}
