{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    impala
  ];
}
