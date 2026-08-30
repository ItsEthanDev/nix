{lib, ...}: {
  hyprzoom =
    import ./hyprzoom;

  default = lib.composeManyExtensions [
    (import ./hyprzoom)
  ];
}
