{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.graphics;
  ipc = "noctalia msg";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.my.graphics.enable = lib.mkEnableOption "opinionated Hyprland and Noctalia graphical environment";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "my.graphics.enable requires Linux.";
      }
      {
        assertion = config.stylix.enable;
        message = "my.graphics.enable requires Stylix.";
      }
    ];

    programs.noctalia = {
      enable = lib.mkDefault true;
      settings = {
        idle.behavior = {
          lock = {
            action = lib.mkDefault "lock";
            enabled = lib.mkDefault true;
            timeout = lib.mkDefault 600;
          };
          lock-and-suspend = {
            action = lib.mkDefault "lock_and_suspend";
            enabled = lib.mkDefault false;
          };
          screen-off = {
            action = lib.mkDefault "screen_off";
            enabled = lib.mkDefault false;
            timeout = lib.mkDefault 660;
          };
        };
        keybinds = {
          down = lib.mkDefault ["Down" "Ctrl+n"];
          up = lib.mkDefault ["Up" "Ctrl+p"];
        };
        shell = {
          font_family = lib.mkDefault config.stylix.fonts.sansSerif.name;
          launcher.categories = lib.mkDefault false;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = lib.mkDefault true;
      configType = lib.mkDefault "hyprlang";
      settings = {
        "binds:scroll_event_delay" = lib.mkDefault 0;
        "cursor:inactive_timeout" = lib.mkDefault 3;
        "decoration:blur:enabled" = lib.mkDefault true;
        "decoration:blur:passes" = lib.mkDefault 2;
        "decoration:blur:size" = lib.mkDefault 3;
        "decoration:blur:vibrancy" = lib.mkDefault 0.1696;
        "decoration:rounding" = lib.mkDefault 20;
        "decoration:rounding_power" = lib.mkDefault 2;
        "decoration:shadow:color" = lib.mkDefault "0xee1a1a1a";
        "decoration:shadow:enabled" = lib.mkDefault true;
        "decoration:shadow:range" = lib.mkDefault 4;
        "decoration:shadow:render_power" = lib.mkDefault 3;
        "general:border_size" = lib.mkDefault 2;
        "general:gaps_in" = lib.mkDefault 5;
        "general:gaps_out" = lib.mkDefault 10;
        "misc:disable_hyprland_logo" = lib.mkDefault true;
        "misc:disable_splash_rendering" = lib.mkDefault true;
        "misc:focus_on_activate" = lib.mkDefault true;
        "misc:middle_click_paste" = lib.mkDefault false;

        exec-once = ["noctalia"];

        bind = [
          "SUPER, C, sendshortcut, CTRL, Insert, activewindow"
          "SUPER, V, sendshortcut, SHIFT, Insert, activewindow"
          "SUPER, X, sendshortcut, CTRL, X, activewindow"
          "SUPER, A, sendshortcut, CTRL, A, activewindow"
          "SUPER, Z, sendshortcut, CTRL, Z, activewindow"
          "SUPER_SHIFT, Z, sendshortcut, CTRL_SHIFT, Z, activewindow"
          "SUPER, W, killactive"
          "SUPER_CTRL, W, forcekillactive"
          "SUPER, F, fullscreen, 0"
          "SUPER, T, togglefloating"
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
          "SUPER_SHIFT, Tab, movewindow, mon:+1 silent"
          "SUPER, space, exec, ${ipc} panel-toggle launcher"
          "SUPER_CTRL, V, exec, ${ipc} panel-toggle clipboard"
          "SUPER_CTRL, space, exec, ${ipc} panel-toggle control-center"
          "SUPER, P, exec, ${ipc} screenshot-fullscreen"
          "SUPER_SHIFT, P, exec, ${ipc} screenshot-region"
          "SUPER, M, exec, ${ipc} mic-mute"
          ", XF86AudioRaiseVolume, exec, ${ipc} volume-up"
          ", XF86AudioLowerVolume, exec, ${ipc} volume-down"
          ", XF86AudioMute, exec, ${ipc} volume-mute"
          ", XF86MonBrightnessUp, exec, ${ipc} brightness-up"
          ", XF86MonBrightnessDown, exec, ${ipc} brightness-down"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        layerrule = {
          name = lib.mkDefault "noctalia";
          "match:namespace" = lib.mkDefault "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
          blur = lib.mkDefault true;
          blur_popups = lib.mkDefault true;
          ignore_alpha = lib.mkDefault 0.5;
          no_anim = lib.mkDefault true;
        };
        windowrule = [
          "float on, match:class ^dev\\.noctalia\\.Noctalia$"
          "size 1080 920, match:class ^dev\\.noctalia\\.Noctalia$"
        ];
      };
    };
  };
}
