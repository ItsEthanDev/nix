{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  cfg = config.my.dictation;
  voxtype = config.services.voxtype.package;
  hasStylix = options ? stylix.enable && config.stylix.enable;
  colors = config.lib.stylix.colors.withHashtag;
  styleManifest = (pkgs.formats.toml {}).generate "voxtype-osd.toml" {
    name = "stylix";
    palette = "package";
    colors = {
      accent = colors.base0D;
      background = colors.base00;
      surface = colors.base01;
      foreground = colors.base05;
      muted = colors.base04;
      success = colors.base0B;
      warning = colors.base0A;
      error = colors.base08;
      recording = colors.base08;
      streaming = colors.base0D;
      transcribing = colors.base0A;
      idle = colors.base04;
    };
  };
  style = pkgs.linkFarm "voxtype-stylix-osd" [
    {
      name = "voxtype-osd.toml";
      path = styleManifest;
    }
  ];
  vadModel = pkgs.fetchurl {
    name = "ggml-silero-v6.2.0.bin";
    url = "https://huggingface.co/ggml-org/whisper-vad/resolve/main/ggml-silero-v6.2.0.bin";
    hash = "sha256-KqJpt4XutTqCmDogUB3ffB2cSOM6tjpBORrGyff7aYc=";
  };
  model = pkgs.fetchurl {
    name = "ggml-small.en.bin";
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.en.bin";
    hash = "sha256-xhONbVjsyDIgl+D5h8MvG+i7ChhTKj+I9zTRu/nEHl0=";
  };
in {
  options.my.dictation.enable = lib.mkEnableOption "local Voxtype dictation with Hyprland controls and a Stylix-aware indicator";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "my.dictation.enable requires Linux.";
      }
      {
        assertion = config.wayland.windowManager.hyprland.enable;
        message = "my.dictation.enable requires Hyprland.";
      }
      {
        assertion = config.services.voxtype.enable;
        message = "my.dictation.enable requires services.voxtype.enable.";
      }
    ];

    services.voxtype = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.voxtype-vulkan;
      environment = {
        PATH = lib.mkDefault (lib.makeBinPath [
          voxtype
          pkgs.coreutils
          pkgs.quickshell
          pkgs.which
          pkgs.ydotool
        ]);
        VOXTYPE_OSD_QML_PATH = lib.mkDefault "${voxtype.src}/quickshell";
        YDOTOOL_SOCKET = lib.mkDefault "/run/ydotoold/socket";
      };
      settings = {
        engine = lib.mkDefault "whisper";
        state_file = lib.mkDefault "auto";
        hotkey.enabled = lib.mkDefault false;
        text.spoken_punctuation = lib.mkDefault true;
        vad = {
          enabled = lib.mkDefault true;
          backend = lib.mkDefault "whisper";
          model = lib.mkDefault "${vadModel}";
        };
        audio = {
          device = lib.mkDefault "default";
          sample_rate = lib.mkDefault 16000;
          max_duration_secs = lib.mkDefault 300;
        };
        whisper = {
          mode = lib.mkDefault "local";
          model = lib.mkDefault "${model}";
          language = lib.mkDefault "en";
          on_demand_loading = lib.mkDefault false;
          threads = lib.mkDefault 8;
        };
        output = {
          mode = lib.mkDefault "paste";
          paste_keys = lib.mkDefault "shift+insert";
          auto_submit = lib.mkDefault false;
          smart_auto_submit = lib.mkDefault false;
          fallback_to_clipboard = lib.mkDefault true;
          wait_for_modifier_release = lib.mkDefault true;
          restore_clipboard = lib.mkDefault true;
          restore_clipboard_delay_ms = lib.mkDefault 500;
          notification.on_transcription = lib.mkDefault false;
        };
        osd = {
          enabled = lib.mkDefault true;
          frontend = lib.mkDefault "quickshell";
          palette = lib.mkDefault (
            if hasStylix
            then "package"
            else "fallback"
          );
          style = lib.mkDefault (
            if hasStylix
            then "${style}"
            else "default"
          );
          layout = lib.mkDefault "compact";
          position = lib.mkDefault "bottom-center";
          top_margin = lib.mkDefault 0.92;
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
  };
}
