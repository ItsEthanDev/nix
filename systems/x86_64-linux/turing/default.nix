_: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [5520 38281];
  networking.firewall.allowedUDPPorts = [5520 38281];

  # These are potential fixes for a network driver bug
  boot.kernelParams = [
    "mt7925e.disable_aspm=1"
    "mt7925_common.disable_clc=1"
  ];

  networking.hostName = "turing";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "25.11";
}
