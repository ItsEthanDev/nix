{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.gaming;
in {
  options.my.gaming = {
    enable = lib.mkEnableOption "Enables steam and gaming options";
    gamepads.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
      description = "Enables improved support for gamepads";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.gamemode.enable = true;

      programs.steam = {
        enable = true;
        extest.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };

      environment.systemPackages = with pkgs; [
        vkbasalt
        retroarch-free
      ];
    })
    (lib.mkIf cfg.gamepads.enable {
      services.udev.packages = [pkgs.game-devices-udev-rules];
      hardware = {
        steam-hardware.enable = true;
        uinput.enable = true;
        xone.enable = true;
      };
      environment.systemPackages = with pkgs; [
        hidapi
      ];
    })
  ];
}
