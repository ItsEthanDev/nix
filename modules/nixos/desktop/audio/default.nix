{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.audio;
in {
  options.my.desktop.audio = {
    enable = lib.mkEnableOption "desktop audio";

    defaultPlaybackVolume = lib.mkOption {
      type = lib.types.float;
      default = 0.125;
      description = "Default PipeWire playback volume for new streams.";
    };

    easyEffectsSupport = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable dconf support for EasyEffects.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = lib.mkDefault false;
    security.rtkit.enable = lib.mkDefault true;

    services.pipewire = {
      enable = lib.mkDefault true;

      alsa = {
        enable = lib.mkDefault true;
        support32Bit = lib.mkDefault true;
      };

      pulse.enable = lib.mkDefault true;
      jack.enable = lib.mkDefault true;

      wireplumber.extraConfig."default-app-volume" = {
        "wireplumber.settings" = {
          "node.stream.default-playback-volume" = lib.mkDefault cfg.defaultPlaybackVolume;
        };
      };
    };

    programs.dconf.enable = lib.mkIf cfg.easyEffectsSupport (lib.mkDefault true);
  };
}
