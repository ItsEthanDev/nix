{lib, ...}: {
  options.my.desktop = {
    monitors.primary = lib.mkOption {
      type = lib.types.nullOr lib.tyes.str;
      default = null;
      description = "Monitor selector to treat as the primary monitor";
    };

    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to the wallpaper that should be used on the desktop";
    };
  };
}
