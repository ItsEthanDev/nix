{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  gtk.enable = true;

  home = {
    username = "ethan";
    homeDirectory = "/home/ethan";
    stateVersion = "25.11";

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
      name = "Banana";
      package = pkgs.banana-cursor;
      size = 24;
    };

    packages = with pkgs; [
      archipelago
      biome
      bun
      cargo
      discord
      fastfetch
      fd
      gcc
      javaPackages.compiler.temurin-bin.jre-25
      jq
      nodejs
      pkg-config
      pnpm
      ripgrep
      rustc
      snes9x
      tlrc
      unzip
      wine
      zip
      zk
    ];
  };

  my = {
    cli = {
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      zoxide.enable = true;
    };
    desktop = {
      noctalia = {
        enable = true;
        compositors.hyprland = {
          enable-integration = true;
          enable-keybindings = true;
          enable-recommended-styling = true;
        };
      };
      hyprland.enable = true;
    };
    development = {
      git = {
        enable = true;
        email = "turing@itsEthan.dev";
        name = "Ethan Brady";
      };
      nixvim.enable = true;
      opencode.enable = true;
    };
    gaming.mangohud.enable = true;
    media.mpd.enable = true;
    remote.ssh.enable = true;
    terminal = {
      fish.enable = true;
      ghostty.enable = true;
      starship.enable = true;
      zellij.enable = true;
      zsh.enable = true;
    };
  };

  programs = {
    btop.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
    };
    home-manager.enable = true;
    lazygit.enable = true;
    opencode = {
      settings.provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama (local)";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {
            "qwen3.6" = {
              name = "Qwen3.6";
            };
          };
        };
      };

      web = {
        enable = true;
        environmentFile = "/home/ethan/.config/opencode/web.env";
        extraArgs = ["--mdns"];
      };
    };
    vesktop.enable = true;
  };

  services = {
    easyeffects.enable = true;
    ollama.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-4,2560x1440@164.80,1920x-360,1"
      "HDMI-A-1,1920x1080@60.00,0x0,1"
      ",preferred,auto,1"
    ];

    workspace = [
      "1, monitor:DP-4, persistent:true, default:true"
      "2, monitor:DP-4, persistent:true"
      "3, monitor:DP-4, persistent:true"
      "4, monitor:DP-4, persistent:true"
      "5, monitor:DP-4, persistent:true"
      "6, monitor:HDMI-A-1, persistent:true, default:true"
      "7, monitor:HDMI-A-1, persistent:true"
      "8, monitor:HDMI-A-1, persistent:true"
      "9, monitor:HDMI-A-1, persistent:true"
      "10, monitor:HDMI-A-1, persistent:true"
    ];
  };

  xdg = {
    desktopEntries.nemo = {
      name = "Nemo";
      exec = lib.getExe' pkgs.nemo-with-extensions "nemo";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["nemo.desktop"];
        "application/x-gnome-saved-search" = ["nemo.desktop"];
      };
    };
    userDirs.enable = true;
  };
}
