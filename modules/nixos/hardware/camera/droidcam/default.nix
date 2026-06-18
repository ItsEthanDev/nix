{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.hardware.camera.droidcam;
in {
  options.my.hardware.camera.droidcam.enable = lib.mkEnableOption "DroidCam camera support";
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.droidcam.enable = true;
      services.usbmuxd.enable = true;
    }
    (lib.mkIf config.programs.obs-studio.enable {
      programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    })
  ]);
}
