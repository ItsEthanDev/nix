_: {
  imports = [
    ./desktop
    ./hardware
    ./gaming
    ./remote
    ./options
  ];

  config = {
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
}
