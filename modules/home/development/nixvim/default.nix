{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmds.nix
    ./keymaps
    ./opts.nix
    ./plugins
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = lib.mkDefault true;
      globals = {
        mapleader = " ";
        maplocalleader = "\\";
      };
      defaultEditor = lib.mkDefault true;
      nixpkgs.useGlobalPackages = lib.mkDefault true;
      viAlias = lib.mkDefault true;
      vimAlias = lib.mkDefault true;
    };
  };
}
