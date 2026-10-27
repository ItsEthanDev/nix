{lib, ...}: {
  bun = import ./bun;
  claude-desktop = import ./claude-desktop;
  hyprzoom = import ./hyprzoom;
  vibe = import ./vibe;
  vite-plus = import ./vite-plus;

  default = lib.composeManyExtensions [
    (import ./bun)
    (import ./claude-desktop)
    (import ./hyprzoom)
    (import ./vibe)
    (import ./vite-plus)
  ];
}
