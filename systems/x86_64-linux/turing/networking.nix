{primaryUser, ...}: {
  my.remote.ssh = {
    enable = true;
    keyDirectory = ../../../static/ssh;
    user = primaryUser;
  };

  networking = {
    firewall = {
      enable = true;
      # SSH (22) TanStack Start (3000) Vite (5173) Hytale (5520) Minecarft (25565) archipelago (38281)
      interfaces.tailscale0 = {
        allowedTCPPorts = [22 3000 5173 5520 25565 38281];
        allowedUDPPorts = [22 3000 5173 5520 25565 38281];
      };
    };
    hostName = "turing";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings.General.Country = "US";
    };
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
