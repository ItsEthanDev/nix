{
  self,
  inputs,
  lib,
  ...
}: {
  hyprzoom = import ./hyprzoom {
    inherit inputs lib;
  };

  default = self.overlays.hyprzoom;
}
