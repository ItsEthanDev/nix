{
  config,
  lib,
  ...
}: {
  options = {
    my.top.launch = lib.mkOption {
      type = lib.types.str;
      description = "Command-line string used to launch the top application";
    };
  };

  config = {
    my.top.launch = lib.mkDefault "${config.my.terminal.exec} btop";
    programs.btop.enable = true;
  };
}
