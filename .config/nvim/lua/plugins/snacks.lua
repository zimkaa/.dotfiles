return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,   -- Показывать скрытые файлы (.env, .config и т.д.)
            ignored = true,  -- Показывать файлы из .gitignore
          },
        },
      },
    },
  },
}
