{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  services.udev.packages = [pkgs.game-devices-udev-rules];
  programs.gamemode.enable = true;

  hardware = {
    steam-hardware.enable = true;
    uinput.enable = true;
    xone.enable = true;
  };

  programs.steam = {
    enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    gamescope
    protonup-qt
    vkbasalt
  ];

  # Refer here for retroarch https://wiki.nixos.org/wiki/Category:Gaming
}
