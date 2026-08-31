{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.noice = {
        enable = lib.mkDefault true;
        settings = {
          # Use Noice's markdown rendering for LSP hover/signature and cmp docs.
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = lib.mkDefault true;
            "vim.lsp.util.stylize_markdown" = lib.mkDefault true;
            "cmp.entry.get_documentation" = lib.mkDefault true;
          };

          # Collapse common file/write progress messages into the compact mini view.
          routes = lib.mkDefault [
            {
              filter = {
                event = "msg_show";
                any = [
                  {find = "%d+L, %d+B";}
                  {find = "; after #%d+";}
                  {find = "; before #%d+";}
                ];
              };
              view = "mini";
            }
          ];

          # Keep search and command input in the lower UI and send long output to a split.
          presets = {
            bottom_search = lib.mkDefault true;
            command_palette = lib.mkDefault true;
            long_message_to_split = lib.mkDefault true;
          };
        };
      };
    };
  };
}
