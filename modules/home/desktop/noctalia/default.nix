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
    enable = lib.mkEnableOption "Noctalia Wayland shell configuration";
    compositors.hyprland = {
      enableIntegration = lib.mkEnableOption "starting Noctalia and applying its window rules in Hyprland";
      enableKeybindings = lib.mkEnableOption "Noctalia's launcher, control-center, screenshot, and media bindings in Hyprland";
      enableRecommendedStyling = lib.mkEnableOption "Noctalia's gaps, rounding, shadow, blur, and layer-rule defaults in Hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !cfg.compositors.hyprland.enableIntegration || config.wayland.windowManager.hyprland.enable;
        message = "Noctalia Hyprland integration requires Hyprland to be enabled.";
      }
      {
        assertion = !cfg.compositors.hyprland.enableKeybindings || cfg.compositors.hyprland.enableIntegration;
        message = "Noctalia Hyprland keybindings require Noctalia Hyprland integration.";
      }
      {
        assertion = !cfg.compositors.hyprland.enableRecommendedStyling || config.wayland.windowManager.hyprland.enable;
        message = "Noctalia Hyprland styling requires Hyprland to be enabled.";
      }
    ];

    programs.noctalia = {
      enable = lib.mkDefault true;
      settings = {
        keybinds = {
          down = ["Down" "Ctrl+n"];
          up = ["Up" "Ctrl+p"];
        };
        shell.launcher.categories = lib.mkDefault false;
      };
    };

    wayland.windowManager.hyprland.settings = lib.mkMerge [
      (lib.mkIf cfg.compositors.hyprland.enableIntegration {
        exec-once = [
          "noctalia"
        ];
        bind = lib.mkIf cfg.compositors.hyprland.enableKeybindings [
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
      (lib.mkIf cfg.compositors.hyprland.enableRecommendedStyling {
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

        layerrule = {
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
