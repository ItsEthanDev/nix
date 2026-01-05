{...}: {
  # Open the firewalls for llama.cpp
  networking.firewall.allowedTCPPorts = [8080];
}
