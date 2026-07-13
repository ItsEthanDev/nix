{
  inputs,
  pkgs,
  ...
}: let
  user = "ethan";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.catppuccin.nixosModules.catppuccin
    inputs.noctalia.nixosModules.default
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine.enable = true;

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

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "frappe";
  };

  environment.systemPackages = with pkgs; [
    gamescope
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  my = {
    boot.silent = true;
    desktop = {
      audio.enable = true;
      graphics = {
        enable = true;
        autoLogin = {
          enable = true;
          user = user;
        };
        defaultSession = "hyprland-uwsm";
        hintWayland = true;
      };
    };
    gaming.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      zsa.enable = true;
    };
    remote.ssh = {
      enable = true;
      keyDirectory = ../../../static/ssh;
      user = user;
    };
    system.users.primary.username = user;
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [5520 38281]; # Hytale and archipelago
      allowedUDPPorts = [5520 38281];
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

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
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
    nix-ld.enable = true;
    noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    zsh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    displayManager.ly = {
      enable = true;
      settings.session_log = null;
    };
    flatpak.enable = true;
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # needed for Wayland
      openFirewall = true;
    };
    tailscale.enable = true;
  };

  system.stateVersion = "25.11";

  time.timeZone = "America/Denver";

  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
  };
}
