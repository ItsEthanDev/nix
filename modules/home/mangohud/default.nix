{...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      full = true;
      gamemode = true;
      no_display = true;
      toggle_hud = "Super_L+Control_L+H";
    };
  };
}
