{pkgs, ...}: {
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
