{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.toggleterm = {
        enable = lib.mkDefault true;
        settings = {
          direction = lib.mkDefault "float";
          open_mapping = lib.mkDefault "[[<C-/>]]";
          insert_mappings = lib.mkDefault true;
          terminal_mappings = lib.mkDefault true;
          start_in_insert = lib.mkDefault true;
          shade_terminals = lib.mkDefault true;
          float_opts.border = lib.mkDefault "curved";
        };
      };
    };
  };
}
