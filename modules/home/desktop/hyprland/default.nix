{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.hyprland;
in {
  options.my.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = lib.mkDefault true;
      configType = lib.mkDefault "hyprlang";
      settings = {
        "general:border_size" = lib.mkDefault 2;

        "cursor:inactive_timeout" = lib.mkDefault 3;

        "binds:scroll_event_delay" = lib.mkDefault 0;

        "misc:disable_hyprland_logo" = lib.mkDefault true;
        "misc:disable_splash_rendering" = lib.mkDefault true;
        "misc:focus_on_activate" = lib.mkDefault true;
        "misc:middle_click_paste" = lib.mkDefault false;
        bind = [
          # Editing
          "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
          "SUPER, V, sendshortcut, SHIFT, Insert, activewindow"
          "SUPER, X, sendshortcut, CTRL, X, activewindow"
          "SUPER, A, sendshortcut, CTRL, A, activewindow"

          # Windows
          "SUPER, W, killactive"
          "SUPER_CTRL, W, forcekillactive"
          "SUPER, F, fullscreen, 0"
          "SUPER, T, togglefloating"

          ## Navigation
          "SUPER, H, movefocus, l"
          "SUPER, J, movefocus, d"
          "SUPER, K, movefocus, u"
          "SUPER, L, movefocus, r"
          "SUPER_SHIFT, H, movewindow, l"
          "SUPER_SHIFT, J, movewindow, d"
          "SUPER_SHIFT, K, movewindow, u"
          "SUPER_SHIFT, L, movewindow, r"
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
          "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
          "SUPER_SHIFT, 0, movetoworkspacesilent, 10"
          "SUPER, Tab, focusmonitor, +1"
          "SUPER_ALT, Tab, movewindow, mon:+1"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}
