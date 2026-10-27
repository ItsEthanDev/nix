{pkgs, ...}:
{
  hyprzoom = pkgs.hyprzoom;
  vibe = pkgs.vibe;
  vite-plus = pkgs.vite-plus;
}
// pkgs.lib.optionalAttrs (pkgs.stdenv.hostPlatform.system == "x86_64-linux") {
  claude-desktop = pkgs.claude-desktop;
}
