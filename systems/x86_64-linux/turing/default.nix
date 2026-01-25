{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [5520];
  networking.firewall.allowedUDPPorts = [5520];

  networking.hostName = "turing";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "25.11";
}
