{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.catppuccin.nixosModules.catppuccin
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  my = {
    desktop = {
      audio.enable = true;
    };
    gaming.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      zsa.enable = true;
    };
    remote.ssh = {
      enable = true;
      keyDirectory = ../../../static/ssh;
    };
    system.users.primary.username = "ethan";
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
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    kdeconnect.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    zsh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
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

  users.users."${config.my.system.users.primary.username}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
  };
}
