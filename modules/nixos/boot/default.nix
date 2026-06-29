{
  config,
  lib,
  ...
}: let
  cfg = config.my.boot;
in {
  options.my.boot = {
    silent = lib.mkEnableOption "Enables silent boot";
  };

  config = {
    boot = lib.mkIf cfg.silent {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}
