{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.terminal;
  copyCommand =
    if pkgs.stdenv.hostPlatform.isLinux
    then lib.getExe' pkgs.wl-clipboard "wl-copy"
    else "pbcopy";
  shellAliases = {
    cat = "bat";
    cd = "z";
    l = "eza -lah";
    ll = "eza -lh";
    ls = "eza --icons=always";
    tree = "eza -T";
  };
in {
  options.my.terminal.enable = lib.mkEnableOption "opinionated interactive terminal environment";

  config = lib.mkIf cfg.enable {
    home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.libnotify];

    programs = {
      bat.enable = lib.mkDefault true;

      eza = {
        enable = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
        git = lib.mkDefault true;
        icons = lib.mkDefault "auto";
      };

      fish = {
        enable = lib.mkDefault true;
        binds."\\cy" = {
          command = "accept-autosuggestion";
          mode = "insert";
        };
        interactiveShellInit = ''
          fish_vi_key_bindings
          set fish_greeting

          function last_history_item
            echo $history[1]
          end
          abbr -a !! --position anywhere --function last_history_item

          function __list_directory_on_change --on-variable PWD
            status is-interactive; and ls
          end
        '';
        shellAbbrs."C" = {
          position = "anywhere";
          expansion = copyCommand;
        };
        inherit shellAliases;
      };

      fzf = {
        enable = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
        fileWidget.options = [
          "-i"
          "-e"
        ];
        historyWidget.options = [
          "-i"
          "-e"
        ];
      };

      herdr = {
        enable = lib.mkDefault true;
        settings = {
          keys = {
            navigate_workspace_down = lib.mkDefault "j";
            navigate_workspace_up = lib.mkDefault "k";
          };
          onboarding = lib.mkDefault false;
          terminal.default_shell = lib.mkDefault (lib.getExe pkgs.fish);
          theme.name = lib.mkDefault "terminal";
          ui.toast.delivery = lib.mkDefault "system";
        };
      };

      starship = {
        enable = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
        enableTransience = lib.mkDefault true;
        settings = {
          bun.disabled = lib.mkDefault true;
          cmd_duration.disabled = lib.mkDefault true;
          gcloud.disabled = lib.mkDefault true;
          git_branch.format = lib.mkDefault "[$branch(:$remote_branch)]($style) ";
          hostname.ssh_symbol = lib.mkDefault "";
          nodejs.disabled = lib.mkDefault true;
          package.disabled = lib.mkDefault true;
          rust.disabled = lib.mkDefault true;
          username.disabled = lib.mkDefault true;
        };
      };

      zoxide = {
        enable = lib.mkDefault true;
        enableFishIntegration = lib.mkDefault true;
      };
    };
  };
}
