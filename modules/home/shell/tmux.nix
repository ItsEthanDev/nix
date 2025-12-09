{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    itsEthan.shell.tmux.enable = lib.mkEnableOption "Enables tmux and custom configuration";
  };

  config = lib.mkIf config.itsEthan.shell.tmux.enable {
    programs = {
      tmux = {
        enable = true;
        terminal = "xterm-256color";
        shell = "\$SHELL";
        escapeTime = 0;
        mouse = true;
        prefix = "C-Space";
        keyMode = "vi";
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavor "mocha"
              set -g @catppuccin_status_background "none"

              set -g @catppuccin_window_number_position "right"
              set -g @catppuccin_window_text "#W"
              set -g @catppuccin_window_current_text "#W"

              set -g status-left ""
              set -g status-right ""
              set -ag status-right "#{E:@catppuccin_status_session}"
              set -ag status-right "#{E:@catppuccin_status_directory}"
            '';
          }
        ];
        extraConfig = ''
          # Runs zsh on mac
          set -g default-command $SHELL

          set-option -g status-position top

          set -g 'status-format[1]' ""

          unbind r
          bind r source-file ~/.config/tmux/tmux.conf

          # Allow tmux to pass through to programs (Needed for yazi image viewer)
          set -g allow-passthrough all
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM

          # Use `v` to start selecting text
          bind -T copy-mode-vi v send -X begin-selection

          # use `y` to copy the selected text
          bind -T copy-mode-vi y send -X copy-selection-and-cancel
        '';
      };
    };
  };
}
