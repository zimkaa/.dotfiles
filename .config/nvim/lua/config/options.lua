-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true

vim.g.lazyvim_python_ruff = "ruff"

vim.opt.scrolloff = 15
vim.opt.colorcolumn = "80,120"

vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }
vim.opt.spelloptions = "camel,noplainbuffer"

-- Включаем отображение невидимых символов
vim.opt.list = true

-- Настраиваем, какими именно символами они будут отображаться
vim.opt.listchars = {
  space = "·",      -- Точка для обычных пробелов
  tab = "<>",       -- Точка для табуляции (первый символ — точка, остальные — пробелы)
  trail = "×",      -- Крестик для лишних пробелов в конце строки (удобно видеть ошибки)
  nbsp = "␣",       -- Символ для неразрывных пробелов - не знаю когда встречается тестирую
  -- multispace = "·", -- Точки появятся только там, где больше одного пробела подряд
  -- leadmultispace = "· ", -- Точки только в отступах в начале строки
}

-- NOTE: for correct root project tree with git worktree
vim.g.root_spec = {
  { ".git", "pyproject.toml", "flake.nix", "Makefile" },
  "lsp",
  "cwd"
}

-- NOTE: for fast work
vim.opt.updatetime = 50
-- NOTE: clipboard
vim.opt.clipboard = "unnamedplus"
-- NOTE: Search ignore case for vscode
vim.opt.ignorecase = true
-- NOTE: disable "ignore" option if the search pattern contains upper case characters for vscode
vim.opt.smartcase = true
