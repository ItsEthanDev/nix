{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [5520 38281]; # Hytale and archipelago
      allowedUDPPorts = [5520 38281];
    };
  };

  my = {
    gaming.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      zsa.enable = true;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };

  services.flatpak.enable = true;

  networking.hostName = "turing";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "25.11";
}
