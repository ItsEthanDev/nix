{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.steamFrame;
  hotplugRestartRule = ''
    ACTION=="add|remove", SUBSYSTEM=="net", ENV{DEVTYPE}=="wlan", \
    RUN+="/run/current-system/systemd/bin/systemctl try-restart wpa_supplicant.service"
  '';
in {
  options = {
    my.steamFrame = {
      enable = lib.mkEnableOption "Steam Frame streaming with an isolated wireless adapter";
      countryCode = lib.mkOption {
        type = lib.types.strMatching "[A-Z]{2}";
        description = "Wireless regulatory country code for the host's physical location.";
      };
      adapterMacAddress = lib.mkOption {
        type = lib.types.strMatching "([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}";
        description = "Permanent MAC address of the Steam Frame wireless adapter.";
      };
    };

    # NetworkManager handles device hotplug over D-Bus. The upstream restart rule
    # stops its shared supplicant on dongle insertion and disconnects home Wi-Fi.
    # Fail on upstream changes so this workaround cannot silently become obsolete.
    services.udev.extraRules = lib.mkOption {
      apply = rules:
        if !cfg.enable
        then rules
        else if lib.hasInfix hotplugRestartRule rules
        then lib.replaceStrings [hotplugRestartRule] [""] rules
        else throw "my.steamFrame: upstream wpa_supplicant hotplug rule changed; reassess the restart workaround.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
        message = "my.steamFrame requires an x86_64-linux host.";
      }
      {
        assertion = config.networking.networkmanager.enable && config.networking.networkmanager.wifi.backend == "wpa_supplicant";
        message = "my.steamFrame requires NetworkManager with the wpa_supplicant backend.";
      }
      {
        assertion = config.programs.steam.enable && config.hardware.steam-hardware.enable && config.programs.steam.remotePlay.openFirewall;
        message = "my.steamFrame requires Steam, Steam hardware rules, and Remote Play firewall support.";
      }
    ];

    # The world regulatory domain disables the dongle's 6 GHz link. Setting only
    # wpa_supplicant's country did not set the global kernel domain on turing.
    boot.extraModprobeConfig = "options cfg80211 ieee80211_regdom=${cfg.countryCode}";

    hardware.steam-hardware.enable = lib.mkDefault true;
    networking = {
      networkmanager = {
        enable = lib.mkDefault true;
        wifi.backend = lib.mkDefault "wpa_supplicant";
        # Ordinary Wi-Fi profiles must not autoconnect through the Frame dongle.
        # NetworkManager requires escaped spaces in allowed-connections IDs.
        settings."device-steam-frame" = {
          "match-device" = "mac:${cfg.adapterMacAddress}";
          "allowed-connections" = "id:Steam\\sFrame\\sWireless\\sAdapter";
        };
      };
      wireless.extraConfig = "country=${cfg.countryCode}";
    };
    programs.steam = {
      enable = lib.mkDefault true;
      remotePlay.openFirewall = lib.mkDefault true;
    };
  };
}
