{pkgs, ...}: {
  home.file = {
    ".config/hypr/adjust_zoom.sh" = {
      source = ./adjust_zoom.sh;
      executable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "general:gaps_out" = 8;
      "general:gaps_in" = 8;
      "cursor:inactive_timeout" = 3;
      "binds:scroll_event_delay" = 0;
      "decoration:rounding" = 8;
      "input:kb_options" = "compose:ralt";
      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swaync"
      ];
      bind = [
        # Find clients by looking for `class: <class>` in `hyprctl clients`
        "SUPER_SHIFT, return, exec, ghostty"
        "SUPER_SHIFT, I, exec, vesktop"
        "SUPER_SHIFT, C, exec, hyprpicker -a"
        "SUPER_SHIFT, B, exec, zen"

        "SUPER, W, killactive"

        "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
        "SUPER, V, sendshortcut, Shift, Insert, activewindow"
        "SUPER, X, sendshortcut, CTRL, X, activewindow"
        "SUPER, A, sendshortcut, CTRL, A, activewindow"

        "SUPER, mouse_up, exec, ~/.config/hypr/adjust_zoom.sh 0.8"
        "SUPER, mouse_down, exec, ~/.config/hypr/adjust_zoom.sh 1.25"
        "SUPER, mouse:274, exec, ~/.config/hypr/adjust_zoom.sh 0"

        "SUPER, P, exec, hyprshot -m output"
        "SUPER_CTRL, P, exec, hyprshot -m region"
        "SUPER_ALT, P, exec, hyprshot -m window"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"
        "SUPER_ALT, H, movewindow, l"
        "SUPER_ALT, J, movewindow, d"
        "SUPER_ALt, K, movewindow, u"
        "SUPER_ALt, L, movewindow, r"

        # "$mod, space, togglespecialworkspace"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        # "$mod_alt, space, movetoworkspace, special"
        #
        "SUPER_ALT, 1, movetoworkspace, 1"
        "SUPER_ALT, 2, movetoworkspace, 2"
        "SUPER_ALT, 3, movetoworkspace, 3"
        "SUPER_ALT, 4, movetoworkspace, 4"
        "SUPER_ALT, 5, movetoworkspace, 5"
        "SUPER_ALT, 6, movetoworkspace, 6"
        "SUPER_ALT, 7, movetoworkspace, 7"
        "SUPER_ALT, 8, movetoworkspace, 8"
        "SUPER_ALT, 9, movetoworkspace, 9"

        "SUPER, F, fullscreen, 0"
        "SUPER, T, togglefloating"
        "SUPER, O, pin"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        # "stayfocused, title:pulsemixer"
        # "float, title:pulsemixer"
        # "pin, title:pulsemixer"
        # "size 37.5% 37.5%, title:pulsemixer"
        # "move 100%-w-8 48, title:pulsemixer"

        "opacity 0.90, class:^com\.mitchellh\.ghostty$"
      ];
    };
  };

  services.cliphist.enable = true;

  services.swaync.enable = true;

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
    hyprsunset
    bc # for adjust_zoom.sh
  ];
}
