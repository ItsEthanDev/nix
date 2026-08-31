{pkgs, ...}: {
  js = import ./js.nix {inherit pkgs;};
  lua = import ./lua.nix {inherit pkgs;};
  pi = import ./pi.nix {inherit pkgs;};
  python = import ./python.nix {inherit pkgs;};
  rust = import ./rust.nix {inherit pkgs;};
}
