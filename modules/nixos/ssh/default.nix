{config, ...}: let
  keyDir = ../../../static/ssh;
  keyFiles = builtins.attrNames (builtins.readDir keyDir);
in {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  users.users = {
    "${config.itsEthan.user.username}".openssh.authorizedKeys.keyFiles =
      map (
        file: "${keyDir}/${file}"
      )
      keyFiles;
  };
}
