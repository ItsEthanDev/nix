{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.hardware.zsa;
in {
  imports = [
    inputs.zapp.nixosModules.default
  ];

  options.my.hardware.zsa.enable = lib.mkEnableOption "Enables support for ZSA hardware";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = builtins.elem pkgs.stdenv.hostPlatform.system ["aarch64-linux" "x86_64-linux"];
        message = "my.hardware.zsa.enable requires a platform supported by the Zapp flake: aarch64-linux or x86_64-linux.";
      }
    ];

    hardware.keyboard.zsa.enable = lib.mkDefault true;
    programs.zapp.enable = lib.mkDefault true;
  };
}
