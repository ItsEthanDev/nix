{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    mangohud.enable = false;
    zsh-syntax-highlighting = {
      enable = false;
    };
  };
}
