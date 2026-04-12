{lib, ...}: {
  home = {
    stateVersion = "24.05";
    username = lib.mkForce "ethan";
    homeDirectory = lib.mkForce "/Users/ethan";
  };
  programs.home-manager.enable = true;
}
