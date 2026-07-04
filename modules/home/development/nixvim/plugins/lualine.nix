{
  config,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.lualine = {
      enable = true;
      settings.sections = {
        lualine_x = [
          # Shows pending command keys
          "%S"
        ];
      };
    };
  };
}
