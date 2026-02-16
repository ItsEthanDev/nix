{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".config/hypr/adjust-zoom.sh" = {
      source = ./adjust-zoom.sh;
      executable = true;
    };
    ".config/hypr/whisper-dictate.sh" = {
      source = ./whisper-dictate.sh;
      executable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # Conflicts with UWSM
    systemd.enable = false;
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

        # LAUNCH
        "SUPER_SHIFT, return, exec, ${config.my.terminal.launch}"
        "SUPER_SHIFT, I, exec, discord"
        "SUPER_SHIFT, C, exec, hyprpicker -a"
        "SUPER_SHIFT, B, exec, zen"
        "SUPER_SHIFT, P, exec, hyprshot -z -m region -o ~/Screenshots"
        "SUPER_SHIFT, S, exec, steam"

        # ACTIONS
        "SUPER, space, exec, walker"
        "SUPER, W, killactive"
        "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
        "SUPER, V, sendshortcut, CTRL_SHIFT, V, activewindow"
        "SUPER, X, sendshortcut, CTRL, X, activewindow"
        "SUPER, A, sendshortcut, CTRL, A, activewindow"
        "SUPER, F, fullscreen, 0"
        "SUPER, T, togglefloating"
        "SUPER, O, pin"
        "SUPER, P, exec, hyprshot -m output -m active -o ~/Screenshots"

        "SUPER_ALT, P, exec, hyprshot -m output -m active --raw | satty -f - --fullscreen --actions-on-escape save-to-clipboard --early-exit --copy-command wl-copy --initial-tool brush"

        ## workspace

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
        "SUPER_ALT, 1, movetoworkspace, 1"
        "SUPER_ALT, 2, movetoworkspace, 2"
        "SUPER_ALT, 3, movetoworkspace, 3"
        "SUPER_ALT, 4, movetoworkspace, 4"
        "SUPER_ALT, 5, movetoworkspace, 5"
        "SUPER_ALT, 6, movetoworkspace, 6"
        "SUPER_ALT, 7, movetoworkspace, 7"
        "SUPER_ALT, 8, movetoworkspace, 8"
        "SUPER_ALT, 9, movetoworkspace, 9"

        # "$mod_alt, space, movetoworkspace, special"

        # TOGGLES
        "SUPER_CTRL, D, exec, ~/.config/hypr/whisper-dictate.sh"
        "SUPER_CTRL, S, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "SUPER_CTRL, M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "SUPER_CTRL, T, togglespecialworkspace, top"
        "SUPER_CTRL, B, togglespecialworkspace, bluetooth"
        "SUPER_CTRL, N, togglespecialworkspace, network"
        "SUPER_CTRL, C, exec, ${config.my.stopwatch.launch}"

        "SUPER, mouse_up, exec, ~/.config/hypr/adjust-zoom.sh 0.8"
        "SUPER, mouse_down, exec, ~/.config/hypr/adjust-zoom.sh 1.25"
        "SUPER, mouse:274, exec, ~/.config/hypr/adjust-zoom.sh 0"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      windowrule = [
        "opacity 0.90, match:class com.mitchellh.ghostty"

        "float on, match:initial_title ^Discord Popout$"
        "pin on, match:initial_title ^Discord Popout$"
        "size (monitor_w*0.25) (monitor_h*0.25), match:initial_title ^Discord Popout$"
        "move (monitor_w-window_w-48) (monitor_h-window_h-48), match:initial_title ^Discord Popout$"

        "float on, match:initial_title ^${config.my.stopwatch.title}$"
        "pin on, match:initial_title ^${config.my.stopwatch.title}$"
        "size 300 150, match:initial_title ^${config.my.stopwatch.title}$"
        "move 0 (monitor_h-window_h), match:initial_title ^${config.my.stopwatch.title}$"
        "border_size 0, match:initial_title ^${config.my.stopwatch.title}$"
        "rounding 0, match:initial_title ^${config.my.stopwatch.title}$"
        "opacity 1, match:initial_title ^${config.my.stopwatch.title}$"
        "no_shadow on, match:initial_title ^${config.my.stopwatch.title}$"
        "no_blur on, match:initial_title ^${config.my.stopwatch.title}$"
      ];
      workspace = [
        "special:top, on-created-empty:${config.my.top.launch}, gapsout:96"
        "special:bluetooth, on-created-empty:ghostty -e bluetui, gapsout:96"
        "special:network, on-created-empty:ghostty -e impala, gapsout:96"
      ];
    };
  };

  services.cliphist.enable = true;

  services.swaync.enable = true;

  home.packages = with pkgs; [
    btop
    bluetui
    hyprpicker
    hyprshot
    hyprsunset
    openai-whisper
    ffmpeg
    wl-clipboard
    satty
    bc # for adjust-zoom.sh
    libnotify
    pulseaudio
    wireplumber
  ];
}
