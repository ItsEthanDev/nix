{pkgs, ...}: {
  hyprzoom = pkgs.hyprzoom;
  kimaki = pkgs.callPackage ./kimaki {};
}
