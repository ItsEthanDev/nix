{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.development.nixvim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmds.nix
    ./keymaps
    ./opts.nix
    ./plugins
  ];

  options.my.development.nixvim.enable = lib.mkEnableOption "nixvim configuration";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      colorscheme = "catppuccin-frappe";
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "frappe";
          transparent_background = true;
          float.transparent = true;
        };
      };
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
  };
}
