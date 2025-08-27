return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          capabilities = {
            general = {
              positionEncodings = { "utf-16" }
            },
          },
        },
      },
    },
  },
}
