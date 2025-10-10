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
      vim.lsp.enable("cspell_ls"),
      vim.lsp.config("cspell_ls", {
        cmd = { "cspell-lsp", "--stdio" },
        filetypes = {
          "lua",
          "python",
          "rust",
          "go",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "gitcommit",
        },
        root_markers = { ".git" },
      }),
    },
  },
}
