{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.terminal.fish;
  copyCommand =
    if pkgs.stdenv.hostPlatform.isLinux
    then lib.getExe' pkgs.wl-clipboard "wl-copy"
    else "pbcopy";
  autoListDirectory = lib.optionalString cfg.listOnDirectoryChange ''
    function __list_directory_on_change --on-variable PWD
      status is-interactive; and ls
    end
  '';
in {
  options.my.terminal.fish = {
    enable = lib.mkEnableOption "Fish configuration";
    listOnDirectoryChange = lib.mkEnableOption "listing the current directory after an interactive directory change";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = lib.mkDefault true;
      binds."\\cy" = {
        command = "accept-autosuggestion";
        mode = "insert";
      };
      interactiveShellInit = ''
        # Vi bindings
        fish_vi_key_bindings

        # Disables the startup greeting
        set fish_greeting

        # Sets the SHELL env variable to the fish location
        set -gx SHELL (which fish)

        # History expansion with !!
        function last_history_item
          echo $history[1]
        end
        abbr -a !! --position anywhere --function last_history_item

        ${autoListDirectory}
      '';
      shellAbbrs."C" = {
        position = "anywhere";
        expansion = copyCommand;
      };
    };
  };
}
