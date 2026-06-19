{
  desktop = import ./desktop;
  hardware = import ./hardware;
  gaming = import ./gaming;
  remote = import ./remote;
  options = import ./options;

  default = {
    imports = [
      ./desktop
      ./hardware
      ./gaming
      ./remote
      ./options
    ];

    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
}
