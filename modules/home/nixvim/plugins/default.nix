{...}: {
  imports = [
    ./blink.nix
    ./ccc.nix
    ./copilot.nix
    ./conform.nix
    ./indent-blankline.nix
    ./lazygit.nix
    ./lsp.nix
    ./lualine.nix
    ./mini
    ./noice.nix
    ./oil.nix
    ./telescope.nix
    ./toggleterm.nix
    ./treesitter.nix
  ];

  programs.nixvim.plugins = {
    gitsigns.enable = true;
    ts-comments.enable = true;
    web-devicons.enable = true;
  };
}
