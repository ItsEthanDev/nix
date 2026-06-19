{lib, ...}: {
  options.my = {
    system.users.primary.username = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The username of the system's primary user";
    };
  };
}
