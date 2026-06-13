_: {
  config.programs.ghostty = {
    clearDefaultKeybinds = true;
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
      # Activate
      "ctrl+space=activate_key_table:vim"
      # Deactivate
      "vim/escape=deactivate_key_table"
      "vim/i=deactivate_key_table"
      # Scroll
      "vim/j=scroll_page_lines:1"
      "vim/k=scroll_page_lines:-1"
      "vim/ctrl+d=scroll_page_down"
      "vim/ctrl+u=scroll_page_up"
      "vim/ctrl+f=scroll_page_down"
      "vim/ctrl+b=scroll_page_up"
      # Jump
      "vim/g>g=scroll_to_top"
      "vim/shift+g=scroll_to_bottom"
      # Search
      "vim/slash=start_search"
      "vim/n=navigate_search:previous"
      "vim/shift+n=navigate_search:next"
      "performable:escape=end_search"
      # Command Pallete
      "vim/shift+;=toggle_command_palette"
      # Splits
      "vim/ctrl+w>v=new_split:right"
      "vim/ctrl+w>s=new_split:down"
      "vim/ctrl+w>o=toggle_split_zoom"
      "vim/ctrl+h=goto_split:left"
      "vim/ctrl+j=goto_split:down"
      "vim/ctrl+k=goto_split:up"
      "vim/ctrl+l=goto_split:right"
      # Resize
      "vim/shift+.=resize_split:right,50"
      "vim/shift+,=resize_split:left,50"
      "vim/shift+==resize_split:down,50"
      "vim/shift+-=resize_split:up,50"
      "vim/ctrl+w>==equalize_splits"
      # Tab
      "vim/t=new_tab"
      "vim/g>t=next_tab"
      "vim/g>shift+t=previous_tab"
      "vim/1>g>t=goto_tab:1"
      "vim/2>g>t=goto_tab:2"
      "vim/3>g>t=goto_tab:3"
      "vim/4>g>t=goto_tab:4"
      "vim/5>g>t=goto_tab:5"
      "vim/6>g>t=goto_tab:6"
      "vim/7>g>t=goto_tab:7"
      "vim/8>g>t=goto_tab:8"
      "vim/9>g>t=goto_tab:9"
      "vim/0>g>t=last_tab"
      # Scratchpad
      "vim/ctrl+/=toggle_quick_terminal"
    ];
  };
}
