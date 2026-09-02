{
  config,
  lib,
  pkgs,
  ...
}: let
  pickColor = pkgs.writeShellApplication {
    name = "pick-color";
    runtimeInputs = [
      pkgs.hyprpicker
      pkgs.wl-clipboard
    ];
    text = ''
      hyprpicker --format hex | wl-copy
    '';
  };
in {
  xdg = {
    desktopEntries = {
      nemo = {
        name = "Nemo";
        exec = lib.getExe' pkgs.nemo-with-extensions "nemo";
      };
      pick-color = {
        name = "Pick Color";
        comment = "Pick a screen color and copy it to the clipboard";
        exec = lib.getExe pickColor;
        terminal = false;
        startupNotify = false;
        categories = ["Utility"];
        settings.Keywords = "color;picker;eyedropper;clipboard;";
      };
      toggle-projector = {
        name = "Show or Hide Projector";
        comment = "Toggle the projector special workspace";
        exec = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch togglespecialworkspace presentation";
        terminal = false;
        startupNotify = false;
        categories = ["Utility"];
        settings.Keywords = "projector;presentation;OBS;workspace;";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = ["zen-beta.desktop"];
        documentViewer = ["org.gnome.Papers.desktop"];
        fileManager = ["nemo.desktop"];
        imageViewer = ["org.gnome.Loupe.desktop"];
        mediaPlayer = ["io.github.celluloid_player.Celluloid.desktop"];
        textEditor = ["nvim.desktop"];
      in {
        # Browser
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        # Text
        "text/plain" = textEditor;
        "text/markdown" = textEditor;
        "application/json" = textEditor;
        "application/x-shellscript" = textEditor;

        # Files
        "inode/directory" = fileManager;
        "application/x-gnome-saved-search" = fileManager;

        # Documents
        "application/pdf" = documentViewer;

        # Images
        "image/apng" = imageViewer;
        "image/avif" = imageViewer;
        "image/bmp" = imageViewer;
        "image/gif" = imageViewer;
        "image/heic" = imageViewer;
        "image/jpeg" = imageViewer;
        "image/jxl" = imageViewer;
        "image/png" = imageViewer;
        "image/svg+xml" = imageViewer;
        "image/tiff" = imageViewer;
        "image/webp" = imageViewer;

        # Audio
        "audio/aac" = mediaPlayer;
        "audio/flac" = mediaPlayer;
        "audio/m4a" = mediaPlayer;
        "audio/mpeg" = mediaPlayer;
        "audio/ogg" = mediaPlayer;
        "audio/opus" = mediaPlayer;
        "audio/wav" = mediaPlayer;
        "audio/webm" = mediaPlayer;

        # Video
        "video/mp4" = mediaPlayer;
        "video/mpeg" = mediaPlayer;
        "video/ogg" = mediaPlayer;
        "video/quicktime" = mediaPlayer;
        "video/webm" = mediaPlayer;
        "video/x-matroska" = mediaPlayer;
        "video/x-msvideo" = mediaPlayer;
      };
    };
    userDirs = {
      enable = true;
      setSessionVariables = false;
    };
  };
}
