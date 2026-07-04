{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.remote.ssh;
in {
  options.my.remote.ssh.enable = lib.mkEnableOption "SSH configuration";

  config = lib.mkIf cfg.enable {
    home.activation.generateSSHKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -f ${config.home.homeDirectory}/.ssh/id_ed25519 ]; then
        ${lib.getExe' pkgs.openssh "ssh-keygen"} -t ed25519 -f ${config.home.homeDirectory}/.ssh/id_ed25519 -q -N ""
      fi
    '';

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
        newton = lib.mkDefault {
          host = "newton";
          hostname = "newton.tailnet.ethanbrady.xyz";
          user = "ethan";
        };
        morse = lib.mkDefault {
          host = "morse";
          hostname = "ethanbrady.xyz";
          user = "ethan";
        };
        mohs = lib.mkDefault {
          host = "mohs";
          hostname = "mohs.tailnet.ethanbrady.xyz";
          user = "ethan";
        };
      };
    };
  };
}
