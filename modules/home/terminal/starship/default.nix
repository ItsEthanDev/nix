{
  config,
  lib,
  ...
}: let
  cfg = config.my.terminal.starship;
in {
  options.my.terminal.starship.enable = lib.mkEnableOption "starship configuration";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      enableTransience = lib.mkDefault true;
      settings = {
        bun.disabled = true;
        cmd_duration.disabled = true;
        gcloud.disabled = true;
        git_branch = {
          format = "[$branch(:$remote_branch)]($style) ";
        };
        hostname.ssh_symbol = "";
        nodejs.disabled = true;
        package.disabled = true;
        rust.disabled = true;
        username.disabled = true;
      };
    };
  };
}
