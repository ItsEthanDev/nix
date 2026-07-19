{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.gaming.steam;
in {
  options.my.gaming.steam.enable = lib.mkEnableOption "Steam gaming support";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
        message = "my.gaming.steam.enable is only supported on x86_64-linux.";
      }
    ];

    hardware.uinput.enable = lib.mkDefault true;

    programs.steam = {
      enable = lib.mkDefault true;
      extest.enable = lib.mkDefault true;
    };
  };
}
