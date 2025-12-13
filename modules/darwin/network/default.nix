{
  config,
  lib,
  ...
}: {
  options = {
    itsEthan.network.name = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Name of this computer on the network";
    };
  };

  config = {
    networking = {
      computerName = config.itsEthan.network.name;
      hostName = config.itsEthan.network.name;
      localHostName = config.itsEthan.network.name;
    };
  };
}
