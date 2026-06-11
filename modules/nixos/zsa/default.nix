{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.zapp.nixosModules.default
  ];

  hardware.keyboard.zsa.enable = true;
  environment.systemPackages = with pkgs; [
    keymapp
  ];
  programs.zapp.enable = true;
}
