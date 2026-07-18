{...}: {
  homebrew.casks = ["ghostty"];

  my = {
    aerospace.enable = true;
    fish.enable = true;
    homebrew.enable = true;
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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

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
