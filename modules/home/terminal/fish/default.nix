{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.terminal.fish;
  copyCommand =
    if pkgs.stdenv.isLinux
    then lib.getExe' pkgs.wl-clipboard "wl-copy"
    else "pbcopy";
in {
  options.my.terminal.fish.enable = lib.mkEnableOption "fish configuration";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      binds = {
        "\\cy" = {
          command = "accept-autosuggestion";
          mode = "insert";
        };
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

        # Auto ls after cd (using zoxide)
        function cd
          z $argv
          ls
        end
      '';
      shellAbbrs = {
        "C" = {
          position = "anywhere";
          expansion = copyCommand;
        };
      };
    };
  };
}
