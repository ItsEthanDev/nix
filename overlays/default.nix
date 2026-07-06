{lib, ...}: {
  hyprzoom =
    import ./hyprzoom;
  opencode =
    import ./opencode;

  default = lib.composeManyExtensions [
    (import ./hyprzoom)
    (import ./opencode)
  ];
}
