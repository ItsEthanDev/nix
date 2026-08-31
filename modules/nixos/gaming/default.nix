{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.gaming;
in {
  options.my.gaming.enable = lib.mkEnableOption "Steam gaming and broad plug-and-play controller support";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
        message = "my.gaming.enable is only supported on x86_64-linux.";
      }
    ];

    environment.systemPackages = [
      pkgs.gamescope
      pkgs.hidapi
    ];

    hardware = {
      steam-hardware.enable = lib.mkDefault true;
      uinput.enable = lib.mkDefault true;
      xone.enable = lib.mkDefault true;
    };

    programs = {
      gamemode.enable = lib.mkDefault true;
      steam = {
        dedicatedServer.openFirewall = lib.mkDefault true;
        enable = lib.mkDefault true;
        extest.enable = lib.mkDefault true;
        localNetworkGameTransfers.openFirewall = lib.mkDefault true;
        remotePlay.openFirewall = lib.mkDefault true;
      };
    };

    services = {
      joycond.enable = lib.mkDefault true;
      udev.packages = [pkgs.game-devices-udev-rules];
    };
  };
}
