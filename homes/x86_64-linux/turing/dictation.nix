{
  config,
  lib,
  pkgs,
  ...
}: let
  voxtype = config.services.voxtype.package;
  model = pkgs.fetchurl {
    name = "ggml-small.en.bin";
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.en.bin";
    hash = "sha256-xhONbVjsyDIgl+D5h8MvG+i7ChhTKj+I9zTRu/nEHl0=";
  };
in {
  assertions = [
    {
      assertion = config.wayland.windowManager.hyprland.enable;
      message = "Turing dictation requires Hyprland.";
    }
  ];

  services.voxtype = {
    enable = true;
    package = pkgs.voxtype-vulkan;
    environment = {
      PATH = lib.makeBinPath [
        voxtype
        pkgs.coreutils
        pkgs.quickshell
        pkgs.which
        pkgs.ydotool
      ];
      VOXTYPE_OSD_QML_PATH = "${voxtype.src}/quickshell";
      YDOTOOL_SOCKET = "/run/ydotoold/socket";
    };
    settings = {
      engine = "whisper";
      state_file = "auto";
      hotkey.enabled = false;
      audio = {
        device = "default";
        sample_rate = 16000;
        max_duration_secs = 300;
      };
      whisper = {
        mode = "local";
        model = "${model}";
        language = "en";
        on_demand_loading = false;
        threads = 8;
      };
      output = {
        mode = "paste";
        paste_keys = "shift+insert";
        auto_submit = false;
        smart_auto_submit = false;
        fallback_to_clipboard = true;
        wait_for_modifier_release = true;
        restore_clipboard = true;
        restore_clipboard_delay_ms = 500;
        notification.on_transcription = false;
      };
      osd = {
        enabled = true;
        frontend = "quickshell";
        palette = "fallback";
        layout = "compact";
        position = "bottom-center";
        top_margin = 0.92;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, D, exec, ${lib.getExe voxtype} record start"
      "SUPER_SHIFT, D, exec, ${lib.getExe voxtype} record toggle"
      "SUPER_CTRL, D, exec, ${lib.getExe voxtype} record cancel"
    ];
    bindr = [
      "SUPER, D, exec, ${lib.getExe voxtype} record stop"
    ];
  };
}
