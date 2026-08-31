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
      settings = {
        automatically-unhide-macos-hidden-apps = lib.mkDefault true;
        default-root-container-layout = lib.mkDefault "tiles";
        default-root-container-orientation = lib.mkDefault "auto";
        gaps = {
          inner = {
            horizontal = lib.mkDefault 8;
            vertical = lib.mkDefault 8;
          };
          outer = {
            top = lib.mkDefault 8;
            bottom = lib.mkDefault 8;
            left = lib.mkDefault 8;
            right = lib.mkDefault 8;
          };
        };
        mode.main.binding = {
          "cmd-f" = lib.mkDefault "fullscreen";
          "cmd-t" = lib.mkDefault "layout floating tiling";

          "cmd-h" = lib.mkDefault "focus left --boundaries all-monitors-outer-frame";
          "cmd-j" = lib.mkDefault "focus down --boundaries all-monitors-outer-frame";
          "cmd-k" = lib.mkDefault "focus up --boundaries all-monitors-outer-frame";
          "cmd-l" = lib.mkDefault "focus right --boundaries all-monitors-outer-frame";

          "cmd-alt-h" = lib.mkDefault "move left --boundaries all-monitors-outer-frame";
          "cmd-alt-j" = lib.mkDefault "move down --boundaries all-monitors-outer-frame";
          "cmd-alt-k" = lib.mkDefault "move up --boundaries all-monitors-outer-frame";
          "cmd-alt-l" = lib.mkDefault "move right --boundaries all-monitors-outer-frame";

          "cmd-1" = lib.mkDefault "workspace 1";
          "cmd-2" = lib.mkDefault "workspace 2";
          "cmd-3" = lib.mkDefault "workspace 3";
          "cmd-4" = lib.mkDefault "workspace 4";
          "cmd-5" = lib.mkDefault "workspace 5";
          "cmd-6" = lib.mkDefault "workspace 6";
          "cmd-7" = lib.mkDefault "workspace 7";
          "cmd-8" = lib.mkDefault "workspace 8";
          "cmd-9" = lib.mkDefault "workspace 9";

          "cmd-alt-1" = lib.mkDefault "move-node-to-workspace 1";
          "cmd-alt-2" = lib.mkDefault "move-node-to-workspace 2";
          "cmd-alt-3" = lib.mkDefault "move-node-to-workspace 3";
          "cmd-alt-4" = lib.mkDefault "move-node-to-workspace 4";
          "cmd-alt-5" = lib.mkDefault "move-node-to-workspace 5";
          "cmd-alt-6" = lib.mkDefault "move-node-to-workspace 6";
          "cmd-alt-7" = lib.mkDefault "move-node-to-workspace 7";
          "cmd-alt-8" = lib.mkDefault "move-node-to-workspace 8";
          "cmd-alt-9" = lib.mkDefault "move-node-to-workspace 9";

          "cmd-alt-tab" = lib.mkDefault "focus-monitor --wrap-around next";
          "cmd-alt-shift-tab" = lib.mkDefault "move-workspace-to-monitor --wrap-around next";
        };
      };
    };
  };
}
