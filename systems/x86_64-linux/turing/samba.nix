{primaryUser, ...}: {
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [445];

  services.samba = {
    enable = true;
    openFirewall = false;
    nmbd.enable = false;
    winbindd.enable = false;

    settings.public = {
      path = "/home/${primaryUser}/Public";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = [primaryUser];
      "create mask" = "0644";
      "directory mask" = "0755";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/${primaryUser}/Public 0750 ${primaryUser} users -"
  ];
}
