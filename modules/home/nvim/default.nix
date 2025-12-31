{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.lazyvim.homeManagerModules.default
  ];

  programs.lazyvim = {
    enable = true;
    configFiles = ./config;

    extras.lang = {
      typescript.enable = true;
    };

    extraPackages = with pkgs; [
      biome
      alejandra
      copilot-language-server
      lua-language-server
      nil
      shfmt
      stylua
      tailwindcss-language-server
      tree-sitter
      typescript-language-server
      vscode-json-languageserver
      vtsls
    ];
  };

  home.packages = with pkgs; [
    cargo
    gcc
  ];

  programs.neovim = {
    defaultEditor = true;
  };
}
