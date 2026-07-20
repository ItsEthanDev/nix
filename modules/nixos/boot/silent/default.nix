{
  config,
  lib,
  ...
}: let
  cfg = config.my.boot.silent;
in {
  options.my.boot.silent.enable = lib.mkEnableOption "silent boot";

  config = lib.mkIf cfg.enable {
    boot = {
      consoleLogLevel = lib.mkDefault 3;
      initrd.verbose = lib.mkDefault false;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}
