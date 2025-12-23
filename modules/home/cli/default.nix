{pkgs, ...}: {
  home.packages = with pkgs; [
    unzip
    zip
    tlrc
    neofetch
    ripgrep
    fd
    zk
    opencode
  ];

  programs = {
    bat.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
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
    };

    fish = {
      shellAliases = {
        cat = "bat";
        cd = "z";
        ls = "eza --icons=always";
        ll = "eza -lh";
        l = "eza -lah";
        tree = "eza -T";
      };
    };
    zsh = {
      shellAliases = {
        cat = "bat";
        cd = "z";
        ls = "eza --icons=always";
        ll = "eza -lh";
        l = "eza -lah";
        tree = "eza -T";
      };
    };
  };
}
