{
  config,
  lib,
  ...
}: let
  cfg = config.my.aerospace;
in {
  options.my.aerospace.enable = lib.mkEnableOption "AeroSpace window manager configuration";

  config = lib.mkIf cfg.enable {
    services.aerospace = {
      enable = lib.mkDefault true;
      settings = lib.mapAttrsRecursive (_: value: lib.mkDefault value) {
        automatically-unhide-macos-hidden-apps = true;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        gaps = {
          inner = {
            horizontal = 8;
            vertical = 8;
          };
          outer = {
            top = 8;
            bottom = 8;
            left = 8;
            right = 8;
          };
        };
        mode.main.binding = {
          "cmd-f" = "fullscreen";
          "cmd-t" = "layout floating tiling";

          "cmd-h" = "focus left --boundaries all-monitors-outer-frame";
          "cmd-j" = "focus down --boundaries all-monitors-outer-frame";
          "cmd-k" = "focus up --boundaries all-monitors-outer-frame";
          "cmd-l" = "focus right --boundaries all-monitors-outer-frame";

          "cmd-alt-h" = "move left --boundaries all-monitors-outer-frame";
          "cmd-alt-j" = "move down --boundaries all-monitors-outer-frame";
          "cmd-alt-k" = "move up --boundaries all-monitors-outer-frame";
          "cmd-alt-l" = "move right --boundaries all-monitors-outer-frame";

          "cmd-1" = "workspace 1";
          "cmd-2" = "workspace 2";
          "cmd-3" = "workspace 3";
          "cmd-4" = "workspace 4";
          "cmd-5" = "workspace 5";
          "cmd-6" = "workspace 6";
          "cmd-7" = "workspace 7";
          "cmd-8" = "workspace 8";
          "cmd-9" = "workspace 9";

          "cmd-alt-1" = "move-node-to-workspace 1";
          "cmd-alt-2" = "move-node-to-workspace 2";
          "cmd-alt-3" = "move-node-to-workspace 3";
          "cmd-alt-4" = "move-node-to-workspace 4";
          "cmd-alt-5" = "move-node-to-workspace 5";
          "cmd-alt-6" = "move-node-to-workspace 6";
          "cmd-alt-7" = "move-node-to-workspace 7";
          "cmd-alt-8" = "move-node-to-workspace 8";
          "cmd-alt-9" = "move-node-to-workspace 9";

          "cmd-alt-tab" = "focus-monitor --wrap-around next";
          "cmd-alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
        };
      };
    };
  };
}
