{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    gtk.icon.enable = true;

    # Overwrites mangohud configuration if enabled
    mangohud.enable = false;

    # Has weird side effects if enabled
    zsh-syntax-highlighting = {
      enable = false;
    };
  };
}
