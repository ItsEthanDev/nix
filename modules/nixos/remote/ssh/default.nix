{
  config,
  lib,
  ...
}: let
  cfg = config.my.remote.ssh;
in {
  options.my.remote.ssh = {
    enable = lib.mkEnableOption "SSH remote access";
    user = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "User whose OpenSSH authorized_keys receives the public keys.";
    };
    keyDirectory = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Directory of regular *.pub files installed when both user and keyDirectory are set.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = lib.mkDefault true;
      settings.KbdInteractiveAuthentication = lib.mkDefault false;
      settings.PasswordAuthentication = lib.mkDefault false;
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
