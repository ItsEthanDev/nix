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

    extras = {
      ai.supermaven.enable = true;
      lang = {
        json.enable = true;
        nix.enable = true;
        typescript.enable = true;
      };
    };

    extraPackages = with pkgs; [
      biome
      alejandra
      copilot-language-server
      lua-language-server
      nil
      statix
      shfmt
      stylua
      tailwindcss-language-server
      tree-sitter
      typescript-language-server
      typescript-go
      vscode-json-languageserver
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
