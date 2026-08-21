{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.terminal.zellij;
  copyCommand =
    if pkgs.stdenv.hostPlatform.isLinux
    then lib.getExe' pkgs.wl-clipboard "wl-copy"
    else "pbcopy";
in {
  options.my.terminal.zellij.enable = lib.mkEnableOption "zellij configuration";

  config = lib.mkIf cfg.enable {
    programs = {
      zellij = {
        enable = lib.mkDefault true;

        layouts = {
          simple = {
            layout = {
              _children = [
                {
                  pane = {
                    size = 1;
                    borderless = true;
                    plugin = {
                      location = "zellij:compact-bar";
                    };
                  };
                }
                {
                  pane = {};
                }
              ];
            };
          };
        };

        extraConfig = lib.mkDefault ''
          keybinds clear-defaults=true {
              locked {
                  bind "Ctrl g" { SwitchToMode "normal"; }
              }
              pane {
                  bind "h" { MoveFocus "left"; }
                  bind "j" { MoveFocus "down"; }
                  bind "k" { MoveFocus "up"; }
                  bind "l" { MoveFocus "right"; }

                  bind "Alt h" { MovePane "left"; }
                  bind "Alt j" { MovePane "down"; }
                  bind "Alt k" { MovePane "up"; }
                  bind "Alt l" { MovePane "right"; }

                  bind "v" { NewPane; SwitchToMode "locked"; }
                  bind "s" { NewPane "down"; SwitchToMode "locked"; }

                  bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
                  bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
                  bind "t" { ToggleFloatingPanes; SwitchToMode "locked"; }
                  bind "w" { CloseFocus; SwitchToMode "locked"; }

                  bind "z" { TogglePaneFrames; SwitchToMode "locked"; }
              }
              tab {
                  bind "1" { GoToTab 1; SwitchToMode "locked"; }
                  bind "2" { GoToTab 2; SwitchToMode "locked"; }
                  bind "3" { GoToTab 3; SwitchToMode "locked"; }
                  bind "4" { GoToTab 4; SwitchToMode "locked"; }
                  bind "5" { GoToTab 5; SwitchToMode "locked"; }
                  bind "6" { GoToTab 6; SwitchToMode "locked"; }
                  bind "7" { GoToTab 7; SwitchToMode "locked"; }
                  bind "8" { GoToTab 8; SwitchToMode "locked"; }
                  bind "9" { GoToTab 9; SwitchToMode "locked"; }

                  bind "h" { GoToPreviousTab; }
                  bind "l" { GoToNextTab; }
                  bind "Alt h" { MoveTab "Left"; }
                  bind "Alt l" { MoveTab "Right"; }

                  bind "n" { NewTab; SwitchToMode "locked"; }
                  bind "c" { SwitchToMode "renametab"; TabNameInput 0; }

                  bind "w" { CloseTab; SwitchToMode "locked"; }
              }
              resize {
                  bind "h" { Resize "Increase left"; }
                  bind "j" { Resize "Increase down"; }
                  bind "k" { Resize "Increase up"; }
                  bind "l" { Resize "Increase right"; }
                  bind "esc" { SwitchToMode "locked"; }
              }
              entersearch {
                  bind "enter" { SwitchToMode "search"; }
                  bind "esc" { SwitchToMode "normal"; }
              }
              search {
                  bind "n" { Search "down"; }
                  bind "N" { Search "up"; }

                  bind "c" { SearchToggleOption "CaseSensitivity"; }
                  bind "o" { SearchToggleOption "WholeWord"; }
                  bind "w" { SearchToggleOption "Wrap"; }
                  bind "esc" { SwitchToMode "normal"; }
              }
              normal {
                  bind "h" { MoveFocus "left"; }
                  bind "j" { MoveFocus "down"; }
                  bind "k" { MoveFocus "up"; }
                  bind "l" { MoveFocus "right"; }

                  bind "Alt h" { MovePane "left"; }
                  bind "Alt j" { MovePane "down"; }
                  bind "Alt k" { MovePane "up"; }
                  bind "Alt l" { MovePane "right"; }

                  bind "1" { GoToTab 1; SwitchToMode "locked"; }
                  bind "2" { GoToTab 2; SwitchToMode "locked"; }
                  bind "3" { GoToTab 3; SwitchToMode "locked"; }
                  bind "4" { GoToTab 4; SwitchToMode "locked"; }
                  bind "5" { GoToTab 5; SwitchToMode "locked"; }
                  bind "6" { GoToTab 6; SwitchToMode "locked"; }
                  bind "7" { GoToTab 7; SwitchToMode "locked"; }
                  bind "8" { GoToTab 8; SwitchToMode "locked"; }
                  bind "9" { GoToTab 9; SwitchToMode "locked"; }

                  bind "p" { SwitchToMode "pane"; }
                  bind "t" { SwitchToMode "tab"; }
                  bind "r" { SwitchToMode "resize"; }
                  bind "i" { EditScrollback; SwitchToMode "locked"; }
                  bind "/" { SwitchToMode "entersearch"; }
                  bind "o" {
                      LaunchOrFocusPlugin "session-manager" {
                          floating true
                          move_to_focused_tab true
                      }
                      SwitchToMode "locked"
                  }
              }
              shared_except "locked" {
                  bind "Ctrl g" { SwitchToMode "locked"; }
                  bind "Ctrl q" { Quit; }
                  bind "Ctrl d" { Detach; }
              }

              shared_except "locked" "renametab" "renamepane" {
                  bind "esc" { SwitchToMode "locked"; }
              }
              renametab {
                  bind "enter" { SwitchToMode "locked"; }
                  bind "esc" { UndoRenameTab; SwitchToMode "locked"; }
              }
              renamepane {
                  bind "enter" { SwitchToMode "locked"; }
                  bind "esc" { UndoRenamePane; SwitchToMode "locked"; }
              }


              shared_among "scroll" "search" {
                  bind "PageDown" { PageScrollDown; }
                  bind "PageUp" { PageScrollUp; }
                  bind "left" { PageScrollUp; }
                  bind "down" { ScrollDown; }
                  bind "up" { ScrollUp; }
                  bind "right" { PageScrollDown; }
                  bind "Ctrl b" { PageScrollUp; }
                  bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
                  bind "d" { HalfPageScrollDown; }
                  bind "Ctrl f" { PageScrollDown; }
                  bind "h" { PageScrollUp; }
                  bind "j" { ScrollDown; }
                  bind "k" { ScrollUp; }
                  bind "l" { PageScrollDown; }
                  bind "Ctrl s" { SwitchToMode "normal"; }
                  bind "u" { HalfPageScrollUp; }
              }
          }

          plugins {
              about location="zellij:about"
              compact-bar location="zellij:compact-bar"
              configuration location="zellij:configuration"
              filepicker location="zellij:strider" {
                  cwd "/"
              }
              plugin-manager location="zellij:plugin-manager"
              session-manager location="zellij:session-manager"
              status-bar location="zellij:status-bar"
              strider location="zellij:strider"
              tab-bar location="zellij:tab-bar"
              welcome-screen location="zellij:session-manager" {
                  welcome_screen true
              }
          }

          load_plugins {
          }
          web_client {
              font "monospace"
          }
          default_mode "locked"
          default_layout "simple"
          pane_frames false
          show_startup_tips false
          copy_command "${copyCommand}"
          copy_on_select true
        '';
      };
    };
  };
}
