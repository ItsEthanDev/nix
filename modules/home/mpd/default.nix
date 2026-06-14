_: {
  services = {
    mpd = {
      enable = true;
      extraConfig = ''
        restore_paused "yes"
        audio_output {
          type "pulse"
          name "PipeWire Pulse"
          mixer_type "software"
        }
      '';
    };

    mpdris2 = {
      enable = true;
      notifications = true;
    };
  };
  programs.rmpc.enable = true;
}
