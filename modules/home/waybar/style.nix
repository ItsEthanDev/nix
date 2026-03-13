_: {
  programs.waybar.style = ''
    * {
      background-color: transparent;
      color: #b5bfe2;
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 12px;
    }

    /* Each of these are the bubbles */
    .modules-left,
    .modules-center > * > *,
    .modules-right {
      background-color: #303446;
      border-radius: 999px;
      padding: 0 10px;
      margin-top: 0;
    }

    /* Add spacing only between center module bubbles */
    .modules-center > * + * > * {
      margin-left: 8px;
    }

    #workspaces button {
      all: initial;
      padding: 0 6px;
      margin: 0 1.5px;
      min-width: 9px;
    }

    #workspaces button.empty {
      opacity: 0.5;
    }

    /* Improved icon spacing */
    #cpu,
    #battery,
    #pulseaudio {
      min-width: 12px;
      margin: 0 7.5px;
    }
    #tray {
      margin-right: 16px;
    }
    #gamemode {
      margin-right: 16px;
    }
    #bluetooth {
      margin-right: 17px;
    }
    #network {
      margin-right: 13px;
    }
    #custom-expand-icon {
      margin-right: 16px;
    }
    #mpd {
      padding-right: 16px;
    }
    #clock {
      margin: 0 1.5px;
    }

    tooltip {
      background-color: #303446;
      border-radius: 8px;
      padding: 2px;
    }

    menu {
      background-color: #303446;
    }

    menuitem {
      background-color: transparent;
    }
  '';
}
