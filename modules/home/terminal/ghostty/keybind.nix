{
  config,
  lib,
  ...
}: let
  cfg = config.my.terminal.ghostty;
in {
  config.programs.ghostty = lib.mkIf cfg.enable {
    clearDefaultKeybinds = lib.mkDefault true;
    settings.keybind = [
      # Quit
      "super+q=quit"
      "super+n=new_window"
      # Reload
      "ctrl+shift+,=reload_config"
      # Copy + Paste
      "shift+insert=paste_from_clipboard"
      "ctrl+insert=copy_to_clipboard"
      # Font size
      "ctrl+shift+-=decrease_font_size:1"
      "ctrl+shift+==increase_font_size:1"
      "ctrl+shift+0=reset_font_size"
    ];
  };
}
