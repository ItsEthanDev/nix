{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmds.nix
    ./keymaps
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
    nixpkgs.useGlobalPackages = true;
    viAlias = true;
    vimAlias = true;
  };
}
