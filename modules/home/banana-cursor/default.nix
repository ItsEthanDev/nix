{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 24;
  };
}
