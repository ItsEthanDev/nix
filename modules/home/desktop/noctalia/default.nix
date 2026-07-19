{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.desktop.noctalia;
  ipc = "noctalia msg";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.my.desktop.noctalia = {
    enable = lib.mkEnableOption "noctalia configuration";
    compositors.hyprland = {
      enable-integration = lib.mkEnableOption "integration with hyprland";
      enable-keybindings = lib.mkEnableOption "default keybindings for hyprland";
      enable-recommended-styling = lib.mkEnableOption "noctalia's recommended styling for hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = lib.mkDefault true;
      settings = {
        keybinds = {
          down = lib.mkDefault ["Down" "Ctrl+n"];
          up = lib.mkDefault ["Up" "Ctrl+p"];
        };
        shell.launcher.categories = lib.mkDefault false;
      };
    };

    wayland.windowManager.hyprland.settings = lib.mkMerge [
      (lib.mkIf cfg.compositors.hyprland.enable-integration {
        exec-once = [
          "noctalia"
        ];
        bind = lib.mkIf cfg.compositors.hyprland.enable-keybindings [
          "SUPER, space, exec, ${ipc} panel-toggle launcher"
          "SUPER_SHIFT, space, exec, ${ipc} bar-toggle"
          "SUPER_CTRL, V, exec, ${ipc} panel-toggle clipboard"

          # Control Center
          "SUPER_CTRL, space, exec, ${ipc} panel-toggle control-center"
          "SUPER_CTRL, A, exec, ${ipc} panel-toggle control-center audio"
          "SUPER_CTRL, B, exec, ${ipc} panel-toggle control-center bluetooth"
          "SUPER_CTRL, N, exec, ${ipc} panel-toggle control-center network"

          # Screenshots
          "SUPER, P, exec, ${ipc} screenshot-fullscreen"
          "SUPER_SHIFT, P, exec, ${ipc} screenshot-region"

          # Notifications
          "SUPER, comma, exec, ${ipc} notification-clear-active"
          "SUPER_SHIFT, comma, exec, ${ipc} notification-invoke-latest"

          ", XF86AudioRaiseVolume, exec, ${ipc} volume-up"
          ", XF86AudioLowerVolume, exec, ${ipc} volume-down"
          ", XF86AudioMute, exec, ${ipc} volume-mute"
          ", XF86MonBrightnessUp, exec, ${ipc} brightness-up"
          ", XF86MonBrightnessDown, exec, ${ipc} brightness-down"
        ];
        windowrule = [
          "float on, match:class ^dev\\.noctalia\\.Noctalia$"
          "size 1080 920, match:class ^dev\\.noctalia\\.Noctalia$"
        ];
      })
      (lib.mkIf cfg.compositors.hyprland.enable-recommended-styling {
        "general:gaps_out" = lib.mkDefault 10;
        "general:gaps_in" = lib.mkDefault 5;

        "decoration:rounding" = lib.mkDefault 20;
        "decoration:rounding_power" = lib.mkDefault 2;
        "decoration:shadow:enabled" = lib.mkDefault true;
        "decoration:shadow:range" = lib.mkDefault 4;
        "decoration:shadow:render_power" = lib.mkDefault 3;
        "decoration:shadow:color" = lib.mkDefault "0xee1a1a1a";
        "decoration:blur:enabled" = lib.mkDefault true;
        "decoration:blur:size" = lib.mkDefault 3;
        "decoration:blur:passes" = lib.mkDefault 2;
        "decoration:blur:vibrancy" = lib.mkDefault 0.1696;

        layerrule = lib.mkDefault {
          name = "noctalia";
          "match:namespace" = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        };
      })
    ];
  };
}
