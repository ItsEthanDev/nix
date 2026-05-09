{...}: {
  imports = [
    ./blink.nix
    ./ccc.nix
    ./copilot.nix
    ./conform.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./lazygit.nix
    ./lsp.nix
    ./lualine.nix
    ./mini
    ./noice.nix
    ./oil.nix
    ./opencode.nix
    ./telescope.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./zk.nix
  ];

  programs.nixvim.plugins = {
    hardtime.enable = true;
    ts-comments.enable = true;
    web-devicons.enable = true;
  };
}
