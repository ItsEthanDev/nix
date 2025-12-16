{
  config,
  lib,
  ...
}: {
  options = {
    itsEthan.locale.timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Denver";
      description = "The time zone to use for the system";
    };
    itsEthan.locale.identifier = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "The locale identifier to use for locale settings";
    };
  };

  config = {
    time.timeZone = config.itsEthan.locale.timezone;
    i18n.defaultLocale = config.itsEthan.locale.identifier;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.itsEthan.locale.identifier;
      LC_IDENTIFICATION = config.itsEthan.locale.identifier;
      LC_MEASUREMENT = config.itsEthan.locale.identifier;
      LC_MONETARY = config.itsEthan.locale.identifier;
      LC_NAME = config.itsEthan.locale.identifier;
      LC_NUMERIC = config.itsEthan.locale.identifier;
      LC_PAPER = config.itsEthan.locale.identifier;
      LC_TELEPHONE = config.itsEthan.locale.identifier;
      LC_TIME = config.itsEthan.locale.identifier;
    };
  };
}
