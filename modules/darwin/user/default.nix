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
    programs.fish.enable = true;
    users.users."${config.itsEthan.user.username}" = {
      shell = pkgs.fish;
    };
    environment.shells = [pkgs.fish];
  };
}
