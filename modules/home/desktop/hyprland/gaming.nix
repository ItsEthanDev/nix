{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop.hyprland;

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
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER_CTRL, G, togglespecialworkspace, gaming"
        "SUPER_CTRL_ALT, G, movetoworkspace, special:gaming"
        "SUPER_CTRL_SHIFT, G, togglespecialworkspace, launchgame"
        "SUPER_CTRL_SHIFT_ALT, G, movetoworkspace, special:launchgame"
      ];
      windowrule =
        [
          "workspace special:launchgame silent, match:initial_class steam"
        ]
        ++ gamingWindowRules;
    };
  };
}
