{
  config,
  lib,
  ...
}: let
  cfg = config.my.remote.ssh;
in {
  options.my.remote.ssh.enable = lib.mkEnableOption "SSH configuration";

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = lib.mkDefault true;
      enableDefaultConfig = lib.mkDefault false;
    };
  };
}
