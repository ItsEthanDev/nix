{...}: {
  imports = [
    ./ai.nix
    ./starter.nix
  ];

  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      surround.enable = true;
    };
  };
}
