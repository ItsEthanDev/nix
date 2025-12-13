{lib, ...}: {
  home.stateVersion = "24.05";
  home.username = lib.mkForce "ethan";
  home.homeDirectory = lib.mkForce "/Users/ethan";
  programs.home-manager.enable = true;
}
