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
      enable = lib.mkDefault true;
      globals = lib.mapAttrsRecursive (_: value: lib.mkDefault value) {
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
