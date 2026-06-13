return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,       -- включить контекст
        max_lines = 7,       -- максимум строк сверху
        trim_scope = "outer",-- обрезать длинные цепочки
        mode = "cursor",     -- обновлять при движении курсора
        line_numbers = true, -- показывать номера строк в контексте
      })
    end,
  },
}
