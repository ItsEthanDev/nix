{lib, ...}: {
  bun = import ./bun;
  hyprzoom = import ./hyprzoom;
  vibe = import ./vibe;

  default = lib.composeManyExtensions [
    (import ./bun)
    (import ./hyprzoom)
    (import ./vibe)
  ];
}
