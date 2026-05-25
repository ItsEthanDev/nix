{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
in {
  home.packages = with pkgs;
    [
      cargo
      rustc
      pkg-config
    ]
    # We'll only install this on Linux because MacOS comes preloaded with a compiler
    ++ lib.optionals isLinux [
      gcc
    ];
}
