{
  inputs,
  lib,
  options,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config =
    {
      catppuccin = {
        enable = true;
        flavor = "frappe";
        gtk.icon.enable = false;

        # Overwrites mangohud configuration if enabled
        mangohud.enable = false;

        # Has weird side effects if enabled
        zsh-syntax-highlighting = {
          enable = false;
        };
      };
    }
    // lib.optionalAttrs (lib.hasAttrByPath ["programs" "nixvim"] options) {
      programs.nixvim = {
        colorscheme = "catppuccin-frappe";
        colorschemes.catppuccin = {
          enable = true;
          flavor = "frappe";
        };
      };
    };
}
