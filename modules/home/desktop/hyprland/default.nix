{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.my.desktop.hyprland;
  audioCommand = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.wiremix}";
  bluetoothCommand = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.bluetui}";
  browserCommand = lib.getExe inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  copyCommand = lib.getExe' pkgs.wl-clipboard "wl-paste";
  launcherCommand = lib.getExe pkgs.walker;
  networkCommand = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.impala}";
  terminalCommand = lib.getExe pkgs.ghostty;
  topCommand = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.btop}";
  wallpaper = ../../../../static/wallpapers/spirals-2560x2560.png;
in {
  imports = [
    ./gaming.nix
  ];

  options.my.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
      # Conflicts with UWSM
      systemd.enable = false;
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
        exec-once = [
          "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch cliphist store"
          "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch cliphist store"
          "swaync"
        ];
        bind = [
          # Find clients by looking for `class: <class>` in `hyprctl clients`

          "SUPER, space, exec, ${launcherCommand}"
          "SUPER_CTRL, L, exec, ${lib.getExe pkgs.hyprshutdown}"

          # LAUNCH
          "SUPER_SHIFT, return, exec, ${terminalCommand}" # [A]I
          "SUPER_SHIFT, C, exec, hyprpicker -a" # [C]olor Picker
          "SUPER_SHIFT, B, exec, ${browserCommand}" # [B]rowser
          "SUPER_SHIFT, P, exec, hyprshot -z -m region -o ${config.xdg.userDirs.pictures}" # [P]ictures

          # ZOOM
          "SUPER, mouse_up, exec, ${lib.getExe pkgs.hyprzoom} 0.8"
          "SUPER, mouse_down, exec, ${lib.getExe pkgs.hyprzoom} 1.25"
          "SUPER, mouse:274, exec, ${lib.getExe pkgs.hyprzoom} 0"

          # COPY/PASTE/CUT/SELECT
          "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
          "SUPER, V, sendshortcut, SHIFT, Insert, activewindow"
          "SUPER_CTRL, V, exec, ${launcherCommand} --provider clipboard"
          "SUPER, X, sendshortcut, CTRL, X, activewindow"
          "SUPER, A, sendshortcut, CTRL, A, activewindow"

          # WINDOWS
          "SUPER, W, killactive"
          "SUPER_CTRL, W, forcekillactive"
          "SUPER, F, fullscreen, 0"
          "SUPER, T, togglefloating"
          "SUPER, O, pin"

          # SCREENSHOT
          "SUPER, P, exec, hyprshot -m output -m active -o ${config.xdg.userDirs.pictures}"
          "SUPER_ALT, P, exec, hyprshot -m output -m active --raw | satty -f - --fullscreen --actions-on-escape save-to-clipboard --early-exit --copy-command ${copyCommand} --initial-tool brush"

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
          "SUPER_CTRL, A, exec, hyprctl dispatch togglespecialworkspace audio"
          "SUPER_CTRL, B, exec, hyprctl dispatch togglespecialworkspace bluetooth"
          "SUPER_CTRL, N, exec, hyprctl dispatch togglespecialworkspace network"
          "SUPER_CTRL, T, exec, hyprctl dispatch togglespecialworkspace top"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        windowrule = [
          "opacity 0.875, match:class com.mitchellh.ghostty"

          "float on, match:initial_title ^Discord Popout$"
          "pin on, match:initial_title ^Discord Popout$"
          "size (monitor_w*0.25) (monitor_h*0.25), match:initial_title ^Discord Popout$"
          "move (monitor_w-window_w-48) (monitor_h-window_h-48), match:initial_title ^Discord Popout$"
        ];
        workspace = [
          "special:audio, on-created-empty:${audioCommand}, gapsout:96"
          "special:bluetooth, on-created-empty:${bluetoothCommand}, gapsout:96"
          "special:network, on-created-empty:${networkCommand}, gapsout:96"
          "special:top, on-created-empty:${topCommand}, gapsout:96"
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
              path = "${wallpaper}";
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
      ffmpeg
      satty
      pulseaudio
      libnotify
    ];
  };
}
