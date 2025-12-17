return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/",
    },
  }
}
