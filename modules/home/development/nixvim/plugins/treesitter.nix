{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.treesitter = {
        enable = lib.mkDefault true;
        settings = lib.mapAttrsRecursive (_: value: lib.mkDefault value) {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };
}
