{
  boot = import ./boot;
  desktop = import ./desktop;
  hardware = import ./hardware;
  gaming = import ./gaming;
  remote = import ./remote;
  options = import ./options;

  default = {
    imports = [
      ./boot
      ./desktop
      ./hardware
      ./gaming
      ./remote
      ./options
    ];
  };
}
