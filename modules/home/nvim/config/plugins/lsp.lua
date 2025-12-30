return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = {
                command = { "alejandra" },
              },
            },
          },
        },
      },
    },
  },
}
