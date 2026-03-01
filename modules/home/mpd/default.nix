{config, ...}: {
  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
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
