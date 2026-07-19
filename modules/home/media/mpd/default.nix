{
  config,
  lib,
  ...
}: let
  cfg = config.my.media.mpd;
in {
  options.my.media.mpd.enable = lib.mkEnableOption "MPD configuration";

  config = lib.mkIf cfg.enable {
    services = {
      mpd = {
        enable = lib.mkDefault true;
        extraConfig = lib.mkDefault ''
          restore_paused "yes"
          audio_output {
            type "pulse"
            name "PipeWire Pulse"
            mixer_type "software"
          }
        '';
      };

      mpdris2 = {
        enable = lib.mkDefault true;
      };
    };
    programs.rmpc.enable = lib.mkDefault true;
  };
}
