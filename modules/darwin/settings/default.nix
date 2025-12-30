{...}: {
  system.defaults = {
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
    controlcenter = {
      BatteryShowPercentage = false;
    };
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
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
