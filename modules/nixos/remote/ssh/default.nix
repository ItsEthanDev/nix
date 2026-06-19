{
  config,
  lib,
  ...
}: let
  cfg = config.my.remote.ssh;
in {
  options.my.remote.ssh = {
    enable = lib.mkEnableOption "SSH remote access";
    passwordAuthentication = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to allow password authentication via ssh";
    };
    user = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = config.my.system.users.primary.username;
      description = "The username of the account to set up remote access for";
    };
    keyDirectory = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "The directory containing public keys which should be used to authorize access";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = lib.mkDefault true;
      settings.PasswordAuthentication = lib.mkDefault cfg.passwordAuthentication;
      settings.KbdInteractiveAuthentication = lib.mkDefault cfg.passwordAuthentication;
    };

    users.users = lib.mkIf (cfg.user != null && cfg.keyDirectory != null) (
      let
        entries = builtins.readDir cfg.keyDirectory;
        keyFiles =
          builtins.filter
          (file: entries.${file} == "regular" && lib.hasSuffix ".pub" file)
          (builtins.attrNames entries);
      in {
        "${cfg.user}".openssh.authorizedKeys.keyFiles =
          map (file: "${cfg.keyDirectory}/${file}") keyFiles;
      }
    );
  };
}
