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
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };
}
