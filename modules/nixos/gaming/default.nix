{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  hardware.uinput.enable = true;
  services.udev.packages = [pkgs.game-devices-udev-rules];

  programs.gamemode.enable = true;

  hardware.xone.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    vkbasalt
    steam-devices-udev-rules
  ];

  services.pipewire = {
    lowLatency.enable = true;
  };

  # Refer here for retroarch https://wiki.nixos.org/wiki/Category:Gaming
}
