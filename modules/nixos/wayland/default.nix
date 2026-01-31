{
  config,
  pkgs,
  ...
}: {
  # True auto-login with greetd (no greeter displayed)
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.bash}/bin/bash -lc 'exec uwsm start hyprland.desktop'";
        user = config.itsEthan.user.username;
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  # Hints to electron and chromium apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Screen sharing + OpenURI support
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };
}
