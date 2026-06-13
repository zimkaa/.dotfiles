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
        -- jedi_language_server = false,
        pyright = {
          settings = {
            python = {
              venvPath = ".",
              pythonPath = "./.venv/bin/python",
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
