{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development.hunk;
  colors = config.lib.stylix.colors.withHashtag;
in {
  options.my.development.hunk.enable = lib.mkEnableOption "Hunk configuration";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.stylix.enable;
        message = "my.development.hunk requires Stylix to be enabled";
      }
    ];

    home.packages = [pkgs.hunk];

    xdg.configFile."hunk/config.toml" = {
      force = true;
      text = ''
        theme = "custom"
        mode = "auto"
        line_numbers = true
        wrap_lines = true
        hunk_headers = true
        menu_bar = false
        agent_notes = false
        copy_decorations = false
        cursor_line = "row"
        prompt_save_view_preferences = false

        [custom_theme]
        base = "github-dark-default"
        label = "Stylix"
        background = "${colors.base00}"
        panel = "${colors.base01}"
        panelAlt = "${colors.base02}"
        border = "${colors.base03}"
        accent = "${colors.base0D}"
        accentMuted = "${colors.base04}"
        text = "${colors.base05}"
        muted = "${colors.base04}"
        addedBg = "${colors.base00}"
        removedBg = "${colors.base00}"
        movedAddedBg = "${colors.base01}"
        movedRemovedBg = "${colors.base01}"
        contextBg = "${colors.base00}"
        addedContentBg = "${colors.base01}"
        removedContentBg = "${colors.base01}"
        contextContentBg = "${colors.base00}"
        addedSignColor = "${colors.base0B}"
        removedSignColor = "${colors.base08}"
        lineNumberBg = "${colors.base00}"
        lineNumberFg = "${colors.base03}"
        selectedHunk = "${colors.base02}"
        badgeAdded = "${colors.base0B}"
        badgeRemoved = "${colors.base08}"
        badgeNeutral = "${colors.base04}"
        fileNew = "${colors.base0B}"
        fileDeleted = "${colors.base08}"
        fileRenamed = "${colors.base0C}"
        fileModified = "${colors.base0A}"
        fileUntracked = "${colors.base0E}"
        noteBorder = "${colors.base0E}"
        noteBackground = "${colors.base01}"
        noteTitleBackground = "${colors.base02}"
        noteTitleText = "${colors.base05}"

        [custom_theme.syntax_scopes]
        "comment" = "${colors.base03}"
        "punctuation.definition.comment" = "${colors.base03}"
        "string" = "${colors.base0B}"
        "constant.numeric" = "${colors.base09}"
        "constant.language" = "${colors.base09}"
        "keyword" = "${colors.base0E}"
        "keyword.operator" = "${colors.base0E}"
        "entity.name.function" = "${colors.base0D}"
        "entity.name.type" = "${colors.base0A}"
        "entity.name.class" = "${colors.base0A}"
        "variable.parameter" = "${colors.base08}"
        "support.function" = "${colors.base0C}"
        "support.type" = "${colors.base0A}"
      '';
    };
  };
}
