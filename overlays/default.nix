{
  inputs,
  lib,
  ...
}: let
  entries = builtins.readDir ./.;

  overlayFiles =
    builtins.attrNames
    (lib.filterAttrs (
        name: type:
          type
          == "regular"
          && lib.hasSuffix ".nix" name
          && name != "default.nix"
      )
      entries);
in
  map (name: import (./. + "/${name}") {inherit inputs;}) overlayFiles
