{lib, ...}: {
  options.my.desktop = {
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to the wallpaper that should be used on the desktop";
    };
  };
}
