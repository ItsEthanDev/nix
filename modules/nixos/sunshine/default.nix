{...}: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # needed for Wayland
    openFirewall = true;
  };
}
