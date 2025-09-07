-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- old keymaps
-- vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = false })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move lines up in visual selection" })

-- -- Not work for my config.
-- -- Centred find word
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>xc", "<cmd>!chmod +x %<CR>", {desc = "execute command"})

if vim.g.vscode then
  -- vim.keymap.set("n", "n", "nzzzv")
  -- vim.keymap.set("n", "N", "Nzzzv")
  local opts = { noremap = true, silent = true }
  local mappings = {
    { "n", "w", "cursorWordPartRight" },
    { "n", "b", "cursorWordPartLeft" },
    { "v", "w", "cursorWordPartRightSelect" },
    { "v", "b", "cursorWordPartLeftSelect" },
    { "n", "<leare>re", "editor.action.rename" },
    -- NOTE: search symbol
    { "n", "<leader>ss", "workbench.action.showAllSymbols" },
    -- NOTE: command panel
    { "n", "<leader>sa", "workbench.action.showCommands" },
    -- NOTE: open files
    { "n", "<leader>sf", "workbench.action.quickOpen" },
    -- NOTE: open definition
    { "n", "<leader>vd", "editor.action.peekDefinition" },
    -- NOTE: open implementation
    { "n", "<leader>vi", "editor.action.peekImplementation" },
    -- NOTE: open type definition
    { "n", "<leader>vt", "editor.action.peekTypeDefinition" },
    -- NOTE: additional info
    { "n", "<leader>vh", "editor.action.showHover" },
    -- NOTE: find references
    { "n", "<leader>fr", "references-view.findReferences" },
    -- NOTE: search trigger
    { "n", "<leader>sr", "editor.action.referenceSearch.trigger" },
  }

  for _, mapping in ipairs(mappings) do
    local mode, key, command = mapping[1], mapping[2], mapping[3]
    vim.keymap.set(mode, key, function()
      vim.fn.VSCodeNotify(command)
    end, opts)
  end
  -- vim.keymap.set("n", "<leader>re", function () vim.fn.VSCodeNotify("editor.action.rename") end, opts)
end
