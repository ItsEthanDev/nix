{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.desktop;
in {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  options.my.desktop.enable = lib.mkEnableOption "opinionated Hyprland desktop with Noctalia and PipeWire audio";

  config = lib.mkIf cfg.enable {
    programs = {
      dconf.enable = lib.mkDefault true;
      hyprland = {
        enable = lib.mkDefault true;
        withUWSM = lib.mkDefault true;
        xwayland.enable = lib.mkDefault true;
      };
      noctalia = {
        enable = lib.mkDefault true;
        recommendedServices.enable = lib.mkDefault true;
      };
    };

    security.rtkit.enable = lib.mkDefault true;
    services = {
      pipewire = {
        enable = lib.mkDefault true;
        alsa = {
          enable = lib.mkDefault true;
          support32Bit = lib.mkDefault true;
        };
        jack.enable = lib.mkDefault true;
        pulse.enable = lib.mkDefault true;
        wireplumber.extraConfig."default-app-volume"."wireplumber.settings" = {
          "node.stream.default-playback-volume" = lib.mkDefault 0.125;
        };
      };
      pulseaudio.enable = lib.mkDefault false;
    };
  };
}
