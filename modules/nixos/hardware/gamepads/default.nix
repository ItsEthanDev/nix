{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.hardware.gamepads;
in {
  options.my.hardware.gamepads.enable = lib.mkEnableOption "Steam hardware, uinput, Xbox, Joy-Con, udev, and HID gamepad support";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.hidapi];

    hardware = {
      steam-hardware.enable = lib.mkDefault true;
      uinput.enable = lib.mkDefault true;
      xone.enable = lib.mkDefault true;
    };

    services = {
      joycond.enable = lib.mkDefault true;
      udev.packages = [pkgs.game-devices-udev-rules];
    };
  };
}
