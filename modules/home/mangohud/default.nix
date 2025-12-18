{...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      no_display = true;
      toggle_hud = "Super_L+Control_L+H";

      gpu_temp = true;
      display_server = true;
      fan = true;
      frametime = true;
      gpu_fan = true;
      ram = true;
      vram = true;
      wine = true;
      gamemode = true;
    };
  };
}
