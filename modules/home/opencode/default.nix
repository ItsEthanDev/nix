{lib, ...}: {
  programs.opencode = {
    enable = true;

    tui = {
      "$schema" = "https://opencode.ai/tui.json";
      theme = lib.mkForce "system";
    };

    web = {
      enable = true;
      environmentFile = "/home/ethan/.config/opencode/web.env";
      extraArgs = ["--mdns"];
    };
  };
}
