{
  boot = import ./boot;
  desktop = import ./desktop;
  hardware = import ./hardware;
  gaming = import ./gaming;
  remote = import ./remote;

  default = {
    imports = [
      ./boot
      ./desktop
      ./hardware
      ./gaming
      ./remote
    ];
  };
}
