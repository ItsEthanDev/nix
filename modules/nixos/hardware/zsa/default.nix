{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.hardware.zsa;
in {
  imports = [
    inputs.zapp.nixosModules.default
  ];

  options.my.hardware.zsa.enable = lib.mkEnableOption "Enables support for ZSA hardware";

  config = lib.mkIf cfg.enable {
    hardware.keyboard.zsa.enable = true;
    programs.zapp.enable = true;
  };
}
