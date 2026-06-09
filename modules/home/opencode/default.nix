{lib, ...}: {
  programs.opencode = {
    enable = true;

    agents = ./agents;
    commands = ./commands;
    skills = ./skills;

    settings.permission.task.commit = "deny";

    tui = {
      "$schema" = "https://opencode.ai/tui.json";
      # keybinds.input_paste = {
      #   key = "super+v";
      #   preventDefault = false;
      # };
      theme = lib.mkForce "system";
    };

    web = {
      enable = true;
      environmentFile = "/home/ethan/.config/opencode/web.env";
      extraArgs = ["--mdns"];
    };
  };
}
