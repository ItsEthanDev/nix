{lib, ...}: {
  bun = import ./bun;
  hyprzoom = import ./hyprzoom;
  vibe = import ./vibe;
  vite-plus = import ./vite-plus;

  default = lib.composeManyExtensions [
    (import ./bun)
    (import ./hyprzoom)
    (import ./vibe)
    (import ./vite-plus)
  ];
}
