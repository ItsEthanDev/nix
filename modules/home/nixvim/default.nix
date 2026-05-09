{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmds.nix
    ./keymaps.nix
    ./opts.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
