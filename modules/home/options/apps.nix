{lib, ...}: let
  appCommand = lib.types.submodule {
    options = {
      command = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Command used to launch this app role";
      };
    };
  };
in {
  options.my.apps = {
    ai = lib.mkOption {
      type = appCommand;
    };
    audio = lib.mkOption {
      type = appCommand;
    };
    bluetooth = lib.mkOption {
      type = appCommand;
    };
    browser = lib.mkOption {
      type = appCommand;
    };
    launcher = lib.mkOption {
      type = appCommand;
    };
    network = lib.mkOption {
      type = appCommand;
    };
    terminal = lib.mkOption {
      type = appCommand;
    };
    top = lib.mkOption {
      type = appCommand;
    };
  };
}
