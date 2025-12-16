{
  config,
  pkgs,
  ...
}: {
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = config.itsEthan.user.username;
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  # Hints to electron and chromium apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Screen sharing support
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };
}
