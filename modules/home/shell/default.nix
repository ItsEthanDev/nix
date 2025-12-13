{
  config,
  lib,
  ...
}:
{
  imports = [
    ./carapace.nix
    ./ghostty.nix
    ./oh-my-posh
    ./tmux.nix
    ./zsh.nix
  ];

  options = {
    itsEthan.shell.enable = lib.mkEnableOption "Enables all custom shell modules and config";
  };

  config = lib.mkIf config.itsEthan.shell.enable {
    home.sessionVariables.EDITOR = "vim";
    programs.zellij.enable = true;
    programs.lazygit.enable = true;

    itsEthan.shell.carapace.enable = true;
    itsEthan.shell.ghostty.enable = true;
    itsEthan.shell.oh-my-posh.enable = true;
    itsEthan.shell.tmux.enable = true;
    itsEthan.shell.zsh.enable = true;
  };

}
