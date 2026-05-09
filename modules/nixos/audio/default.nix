{...}: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.extraConfig."default-app-volume" = {
      "wireplumber.settings" = {
        "node.stream.default-playback-volume" = 0.125;
      };
    };
  };

  # Necessary for the easy-effects daemon to work correctly
  programs.dconf.enable = true;
}
