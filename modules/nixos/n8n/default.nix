{...}: {
  services.n8n = {
    enable = true;
    openFirewall = false;
    # Allows for connectiong over http
    environment.N8N_SECURE_COOKIE = false;
  };
}
