{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    cargo
    gcc
  ];
  programs.neovim.defaultEditor = true;
}
