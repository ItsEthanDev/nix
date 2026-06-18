{lib, ...}: let
  systems = [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];
in {
  forAllSystems = lib.genAttrs systems;
}
