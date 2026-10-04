{
  lib,
  primaryUser,
  ...
}: {
  imports = [
    {
      options.services.udev.extraRules = lib.mkOption {
        apply = rules:
          lib.replaceStrings [
            ''
              ACTION=="add|remove", SUBSYSTEM=="net", ENV{DEVTYPE}=="wlan", \
              RUN+="/run/current-system/systemd/bin/systemctl try-restart wpa_supplicant.service"
            ''
          ] [""]
          rules;
      };
    }
  ];

  boot.extraModprobeConfig = "options cfg80211 ieee80211_regdom=US";

  my.remote.ssh = {
    enable = true;
    keyDirectory = ../../../static/ssh;
    user = primaryUser;
  };

  networking = {
    firewall = {
      enable = true;
      # SSH (22) TanStack Start (3000) Vite (5173) Hytale (5520) Minecraft (25565) archipelago (38281) mdts (8521)
      interfaces.tailscale0 = {
        allowedTCPPorts = [22 3000 5173 5520 6419 8521 25565 38281];
        allowedUDPPorts = [22 3000 5173 5520 6419 25565 38281];
      };
    };
    hostName = "turing";
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
      settings."device-steam-frame" = {
        "match-device" = "mac:9C:04:B6:88:D5:B9";
        "allowed-connections" = "id:Steam\\sFrame\\sWireless\\sAdapter";
      };
    };
    wireless.extraConfig = "country=US";
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services = {
    openssh.openFirewall = false;
    tailscale.enable = true;
  };
}
