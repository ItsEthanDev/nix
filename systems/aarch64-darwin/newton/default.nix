{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.darwinModules.stylix
  ];

  environment.shells = [config.programs.fish.package];

  homebrew.casks = ["ghostty"];

  homebrew = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  my = {
    aerospace.enable = true;
  };

  networking = {
    computerName = "newton";
    hostName = "newton";
    localHostName = "newton";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  programs.fish.enable = true;

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  services.aerospace.settings.on-window-detected = [
    {
      "if".app-id = "com.mitchellh.ghostty";
      run = ["layout tiling"];
    }
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
    fonts.sizes.terminal = 16;
  };

  users.users.ethan.home = "/Users/ethan";

  system = {
    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
      NSGlobalDomain = {
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleShowAllExtensions = true;
        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        AppleTemperatureUnit = "Celsius";
        AppleMetricUnits = 1;
      };
      WindowManager = {
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
      };
      controlcenter.BatteryShowPercentage = false;
      dock = {
        autohide = true;
        orientation = "right";
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        FXRemoveOldTrashItems = true;
        ShowPathbar = true;
      };
    };

    primaryUser = "ethan";
    stateVersion = 5;
  };
}
