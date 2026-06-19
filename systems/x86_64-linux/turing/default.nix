_: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [5520 38281];
  networking.firewall.allowedUDPPorts = [5520 38281];

  my = {
    gaming.enable = true;
    hardware = {
      camera.droidcam.enable = true;
      zsa.enable = true;
    };
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };

  networking.hostName = "turing";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "25.11";
}
