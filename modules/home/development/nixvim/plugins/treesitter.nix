{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.treesitter = {
        enable = lib.mkDefault true;
        settings = {
          auto_install = lib.mkDefault true;
          highlight.enable = lib.mkDefault true;
          indent.enable = lib.mkDefault true;
        };
      };
    };
  };
}
