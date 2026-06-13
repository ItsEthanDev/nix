{
  config,
  pkgs,
  lib,
  options,
  ...
}: let
  toggleStopwatch = pkgs.writeShellScript "toggle-stopwatch" ''
    addr="$(${lib.getExe' pkgs.hyprland "hyprctl"} -j clients | ${lib.getExe pkgs.jq} -r --arg title ${lib.escapeShellArg config.my.stopwatch.title} 'map(select(.initialTitle == $title))[0].address // empty')"

    if [ -n "$addr" ]; then
      ${lib.getExe' pkgs.hyprland "hyprctl"} dispatch closewindow "address:$addr"
    else
      exec ${config.my.stopwatch.launch}
    fi
  '';

  zoom = pkgs.writeShellScript "zoom" ''
    # Check if a delta is provided as an argument
    if [ -z "$1" ]; then
      echo "Usage: $0 <delta>"
      exit 1
    fi

    # Validate that the provided delta is a number
    if ! echo "$1" | ${lib.getExe pkgs.gnugrep} -Eq '^[+-]?[0-9]+(\.[0-9]+)?$'; then
      echo "Error: Delta must be a number"
      exit 1
    fi

    # Get the current cursor zoom factor
    current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk -F': ' '{print $2}')

    # Calculate the new zoom factor
    new_zoom=$(echo "$current * $1" | ${lib.getExe pkgs.bc})

    # Ensure the new zoom factor is at least 1.0
    if [ "$(echo "$new_zoom < 1.0" | ${lib.getExe pkgs.bc})" -eq 1 ]; then
      new_zoom=1.0
    fi

    # Set the new cursor zoom factor
    hyprctl keyword cursor:zoom_factor "$new_zoom"
  '';

  gamingWindowPatterns = import ./gaming.nix;
  gamingWindowRules = builtins.concatLists (
    map (pattern: [
      "workspace special:gaming, match:initial_class ${pattern}"
      "workspace special:gaming, match:initial_title ${pattern}"
      "fullscreen on, match:initial_class ${pattern}"
      "fullscreen on, match:initial_title ${pattern}"
    ])
    gamingWindowPatterns
  );
in {
  options.my = {
    hyprland = {
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../../static/wallpapers/spirals-2560x2560.png;
        description = "Path to the wallpaper to use for Hyprland";
      };
    };
  };

  config =
    {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        # Conflicts with UWSM
        systemd.enable = false;
        # plugins = with pkgs; [
        #   # hyprlandPlugins.hyprwinwrap
        # ];
        settings = {
          "general:gaps_out" = 8;
          "general:gaps_in" = 8;
          "general:border_size" = 2;
          "general:col.inactive_border" = "0xff737994";
          "general:col.active_border" = "0xffbabbf1";
          "cursor:inactive_timeout" = 3;
          "binds:scroll_event_delay" = 0;
          "decoration:rounding" = 8;
          "input:kb_options" = "compose:ralt,caps:escape";
          "misc:disable_hyprland_logo" = true;
          "misc:disable_splash_rendering" = true;
          # plugin = {
          #   hyprwinwrap = {
          #     title = "bg";
          #     pos_x = 0;
          #     pos_y = 0;
          #     size_x = 100;
          #     size_y = 100;
          #   };
          # };
          # exec = [
          #   "${lib.getExe pkgs.ghostty} --title=bg -e ${lib.getExe pkgs.cmatrix}"
          # ];
          exec-once = [
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "swaync"
          ];
          bind = [
            # Find clients by looking for `class: <class>` in `hyprctl clients`

            "SUPER, space, exec, walker"

            # LAUNCH
            "SUPER_SHIFT, return, exec, ${config.my.terminal.launch}"
            "SUPER_SHIFT, A, exec, ${lib.getExe pkgs.ghostty} -e opencode" # [A]I
            "SUPER_SHIFT, I, exec, discord" # [I]nstant Messaging
            "SUPER_SHIFT, C, exec, hyprpicker -a" # [C]olor Picker
            "SUPER_SHIFT, B, exec, zen" # [B]rowser
            "SUPER_SHIFT, P, exec, hyprshot -z -m region -o ${config.xdg.userDirs.pictures}" # [P]ictures
            "SUPER_SHIFT, S, exec, steam" # [S]team

            # ZOOM
            "SUPER, mouse_up, exec, ${zoom} 0.8"
            "SUPER, mouse_down, exec, ${zoom} 1.25"
            "SUPER, mouse:274, exec, ${zoom} 0"

            # COPY/PASTE/CUT/SELECT
            "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
            "SUPER, V, sendshortcut, SHIFT, Insert, activewindow"
            "SUPER, X, sendshortcut, CTRL, X, activewindow"
            "SUPER, A, sendshortcut, CTRL, A, activewindow"

            # WINDOWS
            "SUPER, W, killactive"
            "SUPER, F, fullscreen, 0"
            "SUPER, T, togglefloating"
            "SUPER, O, pin"

            # SCREENSHOT
            "SUPER, P, exec, hyprshot -m output -m active -o ${config.xdg.userDirs.pictures}"
            "SUPER_ALT, P, exec, hyprshot -m output -m active --raw | satty -f - --fullscreen --actions-on-escape save-to-clipboard --early-exit --copy-command wl-copy --initial-tool brush"

            ## WORKSPACE
            "SUPER, H, movefocus, l"
            "SUPER, J, movefocus, d"
            "SUPER, K, movefocus, u"
            "SUPER, L, movefocus, r"
            "SUPER_ALT, H, movewindow, l"
            "SUPER_ALT, J, movewindow, d"
            "SUPER_ALt, K, movewindow, u"
            "SUPER_ALt, L, movewindow, r"
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
            "SUPER_ALT, 1, movetoworkspace, 1"
            "SUPER_ALT, 2, movetoworkspace, 2"
            "SUPER_ALT, 3, movetoworkspace, 3"
            "SUPER_ALT, 4, movetoworkspace, 4"
            "SUPER_ALT, 5, movetoworkspace, 5"
            "SUPER_ALT, 6, movetoworkspace, 6"
            "SUPER_ALT, 7, movetoworkspace, 7"
            "SUPER_ALT, 8, movetoworkspace, 8"
            "SUPER_ALT, 9, movetoworkspace, 9"
            "SUPER_ALT, 0, movetoworkspace, 10"
            "SUPER, Tab, focusmonitor, +1"
            "SUPER_ALT, Tab, movewindow, mon:+1"

            # SYSTEM OVERLAYS
            "SUPER_CTRL, A, togglespecialworkspace, audio"
            "SUPER_CTRL, B, togglespecialworkspace, bluetooth"
            "SUPER_CTRL, N, togglespecialworkspace, network"
            "SUPER_CTRL, T, togglespecialworkspace, top"

            # TOGGLES
            "SUPER_CTRL, S, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "SUPER_CTRL, M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

            # Workspaces
            "SUPER_CTRL, G, togglespecialworkspace, gaming"
            "SUPER_CTRL_ALT, G, movetoworkspace, special:gaming"
            "SUPER_CTRL, L, togglespecialworkspace, special:launchgame"
            "SUPER_CTRL_ALT, L, movetoworkspace, special:launchgame"
          ];
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
          windowrule =
            [
              "opacity 0.875, match:class com.mitchellh.ghostty"

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
            ]
            ++ gamingWindowRules;
          workspace = [
            "special:top, on-created-empty:ghostty -e ${lib.getExe pkgs.btop}, gapsout:96"
            "special:bluetooth, on-created-empty:ghostty -e ${lib.getExe pkgs.bluetui}, gapsout:96"
            "special:network, on-created-empty:ghostty -e ${lib.getExe pkgs.impala}, gapsout:96"
            "special:audio, on-created-empty:ghostty -e ${lib.getExe pkgs.wiremix}, gapsout:96"
          ];
        };
      };
      services = {
        hyprpaper = {
          enable = true;
          settings = {
            wallpaper = [
              {
                monitor = "";
                path = "${config.my.hyprland.wallpaper}";
                fit_mode = "cover";
              }
            ];
          };
        };

        cliphist.enable = true;

        swaync = {
          enable = true;
          settings = {
            notification-icon-size = 32;
          };
        };
      };

      home.packages = with pkgs; [
        hyprpicker
        hyprshot
        hyprsunset
        openai-whisper
        ffmpeg
        wl-clipboard
        satty
        pulseaudio
        bc # for adjust-zoom.sh
        libnotify
      ];
    }
    // lib.optionalAttrs (lib.hasAttrByPath ["my" "waybar"] options) {
      my.waybar = {
        audio.launch = "hyprctl dispatch togglespecialworkspace audio";
        bluetooth.launch = "hyprctl dispatch togglespecialworkspace bluetooth";
        cpu.launch = "hyprctl dispatch togglespecialworkspace top";
        network.launch = "hyprctl dispatch togglespecialworkspace network";
      };
    };
}
