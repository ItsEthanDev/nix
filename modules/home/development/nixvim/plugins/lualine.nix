{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.lualine = {
      enable = lib.mkDefault true;
      settings.sections = {
        lualine_x = lib.mkDefault [
          # Shows pending command keys
          "%S"
        ];
      };
    };
  };
}
