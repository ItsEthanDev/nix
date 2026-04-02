{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    my.waybar = {
      audio = {
        launch = lib.mkOption {
          type = lib.types.str;
          default = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.wiremix}";
          description = "Command to launch the audio module.";
        };
        mute = lib.mkOption {
          type = lib.types.str;
          default = "${lib.getExe pkgs.pamixer} -t";
          description = "Command to mute the audio.";
        };
      };
      bluetooth.launch = lib.mkOption {
        type = lib.types.str;
        default = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.bluetui}";
        description = "Command to launch the bluetooth module.";
      };
      cpu.launch = lib.mkOption {
        type = lib.types.str;
        default = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.btop}";
        description = "Command to launch the cpu module.";
      };
      network.launch = lib.mkOption {
        type = lib.types.str;
        default = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.impala}";
        description = "Command to launch the network module.";
      };
    };
  };

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
            active = "󱓻";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = config.my.waybar.cpu.launch;
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
          on-click = config.my.waybar.network.launch;
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
          on-click = config.my.waybar.bluetooth.launch;
        };

        pulseaudio = {
          format = "{icon}";
          on-click = config.my.waybar.audio.launch;
          on-click-right = config.my.waybar.audio.mute;
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = ["" "" ""];
          };
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
