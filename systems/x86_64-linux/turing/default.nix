{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "turing";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "25.11";
}
