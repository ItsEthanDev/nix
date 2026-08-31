{lib, ...}: {
  bun = import ./bun;
  hyprzoom = import ./hyprzoom;

  default = lib.composeManyExtensions [
    (import ./bun)
    (import ./hyprzoom)
  ];
}
