{
  config,
  lib,
  pkgs,
  ...
}: let
  terminalCommand = lib.getExe pkgs.ghostty;
  gamingWindowPatterns = [
    "^steam_app_.*$"
    "^Hollow Knight Silksong$"
    "^Hytale$"
    "^deadcells$"
    "^Minecraft.*$"
    "^MinaTheHollower$"
    "^UltimateChickenHorse.*$"
  ];
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
  wayland.windowManager.hyprland = {
    systemd.enable = false;
    settings = {
      "misc:mouse_move_enables_dpms" = true;

      exec-once = lib.mkAfter [
        "${lib.getExe pkgs.xrandr} --output DP-4 --primary"
      ];

      bind = lib.mkAfter [
        "SUPER, return, exec, ${terminalCommand}"
        "SUPER, mouse_down, exec, ${lib.getExe pkgs.hyprzoom} 0.8"
        "SUPER, mouse_up, exec, ${lib.getExe pkgs.hyprzoom} 1.25"
        "SUPER, mouse:274, exec, ${lib.getExe pkgs.hyprzoom} 0"
        "SUPER, G, togglespecialworkspace, gaming"
        "SUPER_CTRL, G, togglespecialworkspace, launchgame"
      ];
      monitor = [
        "DP-4,2560x1440@164.80,1920x-360,1"
        "HDMI-A-1,1920x1080@60.00,0x0,1"
        ",preferred,auto,1"
      ];
      windowrule = lib.mkAfter (
        [
          # Ghostty
          "opacity 0.875, match:class com.mitchellh.ghostty"
          # Discord
          "float on, match:initial_title ^Discord Popout$"
          "pin on, match:initial_title ^Discord Popout$"
          "size (monitor_w*0.25) (monitor_h*0.25), match:initial_title ^Discord Popout$"
          "move (monitor_w-window_w-48) (monitor_h-window_h-48), match:initial_title ^Discord Popout$"
          # Steam
          "workspace special:launchgame silent, match:initial_class ^steam$, match:initial_title negative:^Steam Input On-screen Keyboard$"
          "workspace unset, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "float on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "no_focus on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "pin on, match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          "move ((monitor_w-window_w)/2) (monitor_h-window_h), match:initial_class ^steam$, match:initial_title ^Steam Input On-screen Keyboard$"
          # OBS
          "workspace special:presentation silent, match:initial_title ^Projector.*$"
          "fullscreen on, match:initial_title ^Projector.*$"
        ]
        ++ gamingWindowRules
      );
      workspace = [
        "1, monitor:DP-4, persistent:true, default:true"
        "2, monitor:DP-4, persistent:true"
        "3, monitor:DP-4, persistent:true"
        "4, monitor:DP-4, persistent:true"
        "5, monitor:DP-4, persistent:true"
        "6, monitor:HDMI-A-1, persistent:true, default:true"
        "7, monitor:HDMI-A-1, persistent:true"
        "8, monitor:HDMI-A-1, persistent:true"
        "9, monitor:HDMI-A-1, persistent:true"
        "10, monitor:HDMI-A-1, persistent:true"
      ];
    };
  };
}
