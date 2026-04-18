{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ];

    settings = {
      "plugin:dynamic-cursors" = {
        enabled = true;
        mode = "tilt";

        shake = {
          enabled = true;
        };
      };
    };
  };
}
