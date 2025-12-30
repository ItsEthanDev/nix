{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";

    # Overwrites mangohud configuration if enabled
    mangohud.enable = false;

    # Has weird side effects if enabled
    zsh-syntax-highlighting = {
      enable = false;
    };
  };
}
