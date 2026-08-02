{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  mandelbrust = inputs.mandelbrust.packages.${pkgs.stdenv.hostPlatform.system}.default;
  pickColor = pkgs.writeShellApplication {
    name = "pick-color";
    runtimeInputs = [
      pkgs.hyprpicker
      pkgs.wl-clipboard
    ];
    text = ''
      hyprpicker --format hex | wl-copy
    '';
  };
  terminalCommand = lib.getExe pkgs.ghostty;
  wallpaper = pkgs.runCommand "mandelbrust-spirals-wallpaper.png" {} ''
    ${mandelbrust}/bin/mandelbrust render \
      --preset spirals \
      --size 3840x2160 \
      --outside-color ${colors.base05} \
      --inside-color ${colors.base01} \
      --output "$out" \
      --quiet
  '';
  gamingWindowPatterns = [
    "^steam_app_.*$"
    "^Hollow Knight Silksong$"
    "^Hytale$"
    "^deadcells$"
    "^Minecraft.*$"
    "^MinaTheHollower$"
    "^UltimateChickenHorse.*$"
  ];
  gamingWindowRules = builtins.concatLists (
    map (pattern: [
      "workspace special:gaming, match:initial_class ${pattern}"
      "workspace special:gaming, match:initial_title ${pattern}"
      "fullscreen on, match:initial_class ${pattern}"
      "fullscreen on, match:initial_title ${pattern}"
    ])
    gamingWindowPatterns
  );
in {
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.zen-browser.homeModules.default
  ];

  gtk.enable = true;

  home = {
    username = "ethan";
    homeDirectory = "/home/ethan";
    stateVersion = "25.11";

    pointerCursor = {
      enable = true;
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
      gh
      hunk
      inputs.barnyard.packages.${pkgs.stdenv.hostPlatform.system}.barnyard
      javaPackages.compiler.temurin-bin.jre-25
      jq
      nodejs
      pkg-config
      pnpm
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
      gitShortcuts.enable = true;
      zoxide.enable = true;
    };
    desktop = {
      noctalia = {
        enable = true;
        compositors.hyprland = {
          enableIntegration = true;
          enableKeybindings = true;
          enableRecommendedStyling = true;
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
    gaming.mangohud = {
      enable = true;
      enableSessionWide = true;
    };
    remote.ssh.enable = true;
    terminal = {
      fish = {
        enable = true;
        listOnDirectoryChange = true;
      };
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
    };
    rmpc.enable = true;
    vesktop.enable = true;
    zen-browser = {
      enable = true;
      configPath = "${config.home.homeDirectory}/.zen";
      profiles."Default Profile" = {
        isDefault = true;
        path = "75qjbewr.Default Profile";
      };
    };
  };

  services = {
    easyeffects.enable = true;
    mpd = {
      enable = true;
      extraConfig = ''
        restore_paused "yes"
        audio_output {
          type "pulse"
          name "PipeWire Pulse"
          mixer_type "software"
        }
      '';
    };
    mpdris2.enable = true;
    ollama.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
    fonts.sizes.terminal = 16;
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    image = wallpaper;
    targets.zen-browser.profileNames = ["Default Profile"];
  };

  wayland.windowManager.hyprland = {
    systemd.enable = false;
    settings = {
      "misc:mouse_move_enables_dpms" = true;

      bind = [
        "SUPER, return, exec, ${terminalCommand}"
        "SUPER, mouse_up, exec, ${lib.getExe pkgs.hyprzoom} 0.8"
        "SUPER, mouse_down, exec, ${lib.getExe pkgs.hyprzoom} 1.25"
        "SUPER, mouse:274, exec, ${lib.getExe pkgs.hyprzoom} 0"
        "SUPER, G, togglespecialworkspace, gaming"
        "SUPER_CTRL, G, togglespecialworkspace, launchgame"
      ];
      monitor = [
        "DP-4,2560x1440@164.80,1920x-360,1"
        "HDMI-A-1,1920x1080@60.00,0x0,1"
        ",preferred,auto,1"
      ];
      windowrule =
        [
          # Ghostty
          "opacity 0.875, match:class com.mitchellh.ghostty"
          # Discord
          "float on, match:initial_title ^Discord Popout$"
          "pin on, match:initial_title ^Discord Popout$"
          "size (monitor_w*0.25) (monitor_h*0.25), match:initial_title ^Discord Popout$"
          "move (monitor_w-window_w-48) (monitor_h-window_h-48), match:initial_title ^Discord Popout$"
          # Steam
          "workspace special:launchgame silent, match:initial_class ^steam$, match:initial_title negative:^Steam Input On-screen Keyboard$"
          "workspace unset, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "float on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "no_focus on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "pin on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "move ((monitor_w-window_w)/2) (monitor_h-window_h), match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          # OBS
          "workspace special:presentation silent, match:initial_title ^Projector.*$"
          "fullscreen on, match:initial_title ^Projector.*$"
        ]
        ++ gamingWindowRules;
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
  };

  xdg = {
    desktopEntries = {
      nemo = {
        name = "Nemo";
        exec = lib.getExe' pkgs.nemo-with-extensions "nemo";
      };
      pick-color = {
        name = "Pick Color";
        comment = "Pick a screen color and copy it to the clipboard";
        exec = lib.getExe pickColor;
        terminal = false;
        startupNotify = false;
        categories = ["Utility"];
        settings.Keywords = "color;picker;eyedropper;clipboard;";
      };
      toggle-projector = {
        name = "Show or Hide Projector";
        comment = "Toggle the projector special workspace";
        exec = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch togglespecialworkspace presentation";
        terminal = false;
        startupNotify = false;
        categories = ["Utility"];
        settings.Keywords = "projector;presentation;OBS;workspace;";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["nemo.desktop"];
        "application/x-gnome-saved-search" = ["nemo.desktop"];
      };
    };
    userDirs = {
      enable = true;
      setSessionVariables = false;
    };
  };
}
