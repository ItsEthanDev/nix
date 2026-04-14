{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings.sections = {
      lualine_x = [
        # Shows pending command keys
        "%S"
      ];
    };
  };
}
