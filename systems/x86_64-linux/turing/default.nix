{pkgs, ...}: let
  user = "ethan";
in {
  imports = [
    ./appearance.nix
    ./backup.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  _module.args.primaryUser = user;

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 20;
      };
      timeout = 0;
    };
    plymouth = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      retroarch-free
    ];
  };

  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  my = {
    desktop.enable = true;
    gaming.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      zsa.enable = true;
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
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    zsh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  services.flatpak.enable = true;

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
