-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true

vim.g.lazyvim_python_ruff = "ruff"

vim.opt.scrolloff = 15

vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }
-- vim.opt.spellfile = ".nvim/local.utf-8.add"

vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
