{
  config,
  inputs,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  mandelbrust = inputs.mandelbrust.packages.${pkgs.stdenv.hostPlatform.system}.default;
  user = "ethan";
  wallpaper = pkgs.runCommand "mandelbrust-spirals-wallpaper.png" {} ''
    ${mandelbrust}/bin/mandelbrust render \
      --preset spirals \
      --size 3840x2160 \
      --outside-color ${colors.base05} \
      --inside-color ${colors.base01} \
      --output "$out" \
      --quiet
  '';
in {
  imports = [
    ./hardware-configuration.nix
    inputs.noctalia.nixosModules.default

    inputs.noctalia-greeter.nixosModules.default
    inputs.stylix.nixosModules.stylix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 20;
      };

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = 0;
    };

    plymouth = {
      enable = true;
      # theme = "rings";
      # themePackages = with pkgs; [
      #   (adi1090x-plymouth-themes.override {
      #     selected_themes = ["rings"];
      #   })
      # ];
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      gamescope
      retroarch-free
      vkbasalt
    ];
  };

  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  my = {
    boot.silent.enable = true;
    desktop.audio.enable = true;
    gaming.steam.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      gamepads.enable = true;
      zsa.enable = true;
    };
    remote = {
      ssh = {
        enable = true;
        keyDirectory = ../../../static/ssh;
        user = user;
      };
    };
  };

  networking = {
    firewall = {
      enable = true;
      # TanStack Start (3000) Vite (5173) Hytale (5520) archipelago (38281)
      allowedTCPPorts = [3000 5173 5520 38281];
      allowedUDPPorts = [3000 5173 5520 38281];
    };
    hostName = "turing";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings.General.Country = "US";
    };
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    gamemode.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    kdeconnect.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        stdenv.cc.cc.lib
        fontconfig
        libx11
        libice
        libsm
      ];
    };
    noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
    noctalia-greeter = {
      enable = true;
      settings = {
        session.default = "Hyprland (uwsm-managed)";
        appearance = {
          scheme = "Synced";
          hide_logo = false;
          theme_mode =
            if config.stylix.polarity == "light"
            then "light"
            else "dark";
          font_family = config.stylix.fonts.sansSerif.name;
          palette = with colors.withHashtag; {
            primary = base0D;
            on_primary = base00;
            secondary = base0E;
            on_secondary = base00;
            tertiary = base0C;
            on_tertiary = base00;
            error = base08;
            on_error = base00;
            surface = base00;
            on_surface = base05;
            surface_variant = base01;
            on_surface_variant = base04;
            outline = base03;
            shadow = base00;
            hover = base0C;
            on_hover = base00;
          };
          wallpaper = {
            path = "${wallpaper}";
            fill_mode = "crop";
          };
        };
      };
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    steam = {
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    zsh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    flatpak.enable = true;
    restic.backups.r2 = {
      repository = "s3:https://7be572932f308ef922603015d775fdd2.r2.cloudflarestorage.com/backup/turing";
      environmentFile = "/etc/restic/r2.env";
      passwordFile = "/etc/restic/password";

      paths = [
        "/home/ethan/Pictures/Screenshots"
        "/home/ethan/Documents"
      ];
      exclude = [];

      extraOptions = [
        "s3.bucket-lookup=path"
      ];

      timerConfig = {
        OnCalendar = "*-*-* 03:00:00";
        RandomizedDelaySec = "1h";
        Persistent = true;
      };

      pruneOpts = [
        "--keep-daily 14"
        "--keep-weekly 8"
        "--keep-monthly 12"
        "--keep-yearly 3"
      ];

      inhibitsSleep = true;
      initialize = true;
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # needed for Wayland
      openFirewall = true;
    };
    tailscale.enable = true;
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sizes.terminal = 16;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    image = wallpaper;
  };

  system.stateVersion = "25.11";

  time.timeZone = "America/Denver";

  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  virtualisation.docker = {
    enable = true;
  };
}
