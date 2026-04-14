{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nodejs
    pnpm
    bun
    biome
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
  ];

  programs.fish.shellInit = ''
    fish_add_path -g /Users/ethan/.bun/bin
  '';
}
