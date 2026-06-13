return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- показывать скрытые и gitignored
        hide_dotfiles = false, -- НЕ скрывать .файлы
        hide_gitignored = false, -- НЕ скрывать .gitignored
        never_show = {}, -- пусто = не запрещаем ничего
        never_show_by_pattern = {}, -- убираем все запреты по шаблонам
      },
    },
  },
}
