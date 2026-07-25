{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.remote.kimaki;
in {
  options.my.remote.kimaki = {
    enable = lib.mkEnableOption "Kimaki Discord agent orchestrator";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ../../../../packages/kimaki {};
      description = "Kimaki package to run.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "%h/.kimaki";
      description = "Persistent Kimaki state directory, interpreted by systemd for the running user.";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional arguments passed to Kimaki.";
    };
  };

  config = lib.mkIf cfg.enable {
    # First-time setup needs an interactive terminal for Discord authorization.
    # Stop this service, run `nix run .#kimaki -- --data-dir ~/.kimaki` once,
    # then start the service again with `systemctl --user start kimaki`.
    systemd.user.services.kimaki = {
      description = "Kimaki Discord agent orchestrator";
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];

      path = [
        pkgs.bash
        pkgs.bun
        pkgs.curl
        pkgs.fd
        pkgs.file
        pkgs.git
        pkgs.gh
        pkgs.gnutar
        pkgs.gzip
        pkgs.jq
        config.nix.package
        pkgs.nodejs
        pkgs.opencode
        pkgs.openssh
        pkgs.pnpm
        pkgs.procps
        pkgs.python3
        pkgs.ripgrep
        pkgs.unzip
        pkgs.wget
        pkgs.which
        pkgs.zip
      ];

      serviceConfig = {
        ExecStart = lib.escapeShellArgs (
          [
            (lib.getExe cfg.package)
            "--auto-restart"
            "--data-dir"
            cfg.dataDir
            "--no-auto-upgrade"
          ]
          ++ cfg.extraArgs
        );
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
