{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    itsEthan.user.username = lib.mkOption {
      type = lib.types.str;
      default = "ethan";
      description = "The username for the user account";
    };
  };

  config = {
    security.sudo.wheelNeedsPassword = false;
    programs.zsh.enable = true;
    users.users."${config.itsEthan.user.username}" = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };
}
