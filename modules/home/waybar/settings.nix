{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.waybar.settings = [
      {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        margin = "8 8 0 8";
        spacing = 0;
        height = 26;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "mpd"
        ];
        modules-right = [
          "group/tray-expander"
          "gamemode"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "battery"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
            active = "󱓻";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
        };

        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = config.my.apps.top.activate;
        };

        clock = {
          format = "{:L%A %H:%M}";
          format-alt = "{:L%d %B %Y}";
          tooltip = false;
        };
        mpd = {
          format = "{stateIcon} {title} ({volume}%) ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          interval = 10;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "{album} - {artist} - {title} ({elapsedTime}/{totalTime})";
          tooltip-format-disconnected = "MPD (disconnected)";
          on-click = "${lib.getExe pkgs.mpc} toggle";
          on-click-right = "${lib.getExe pkgs.mpc} next";
          on-scroll-up = "${lib.getExe pkgs.mpc} volume +5";
          on-scroll-down = "${lib.getExe pkgs.mpc} volume -5";
        };

        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          spacing = 1;
          on-click = config.my.apps.network.activate;
        };

        battery = {
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        bluetooth = {
          format = "";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-no-controller = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = config.my.apps.bluetooth.activate;
        };

        pulseaudio = {
          format = "{icon}";
          on-click = config.my.apps.audio.activate;
          on-click-right = "${lib.getExe pkgs.pamixer} -t";
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = ["" "" ""];
          };
        };

        gamemode = {
          format = "{glyph}";
          format-alt = "{glyph}";
          glyph = "🎮";
          hide-not-running = true;
          use-icon = true;
          icon-name = "input-gaming-symbolic";
          icon-spacing = 0;
          icon-size = 12;
          tooltip = true;
          tooltip-format = "Games running: {count}";
        };

        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 600;
            children-class = "tray-group-item";
          };
          modules = ["custom/expand-icon" "tray"];
        };

        "custom/expand-icon" = {
          format = "";
          tooltip = false;
          on-scroll-up = "";
          on-scroll-down = "";
          on-scroll-left = "";
          on-scroll-right = "";
        };

        tray = {
          icon-size = 12;
          spacing = 17;
        };
      }
    ];
  };
}
