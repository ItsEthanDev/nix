{pkgs, ...}: {
  home.packages = with pkgs; [
    opencode
    beads
  ];

  xdg.configFile."opencode/tui.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/tui.json";
    theme = "system";
  };
}
