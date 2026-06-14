{lib, ...}: {
  imports = [
    ./apps.nix
    ./desktop.nix
  ];

  options.my = {
    clipboard = {
      history = {
        launch = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Command used to launch clipboard history";
        };
      };
    };
  };
}
