return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Добавляем отображение кодировки (например, utf-8) в секцию lualine_x (справа)
      table.insert(opts.sections.lualine_x, "encoding")
      -- По желанию: можно добавить формат файла (unix/dos)
      -- table.insert(opts.sections.lualine_x, "fileformat")
      local function get_file_permissions()
        local file = vim.fn.expand("%") -- получаем путь к активному буферу
        if file == "" then
          return ""
        end
        return vim.fn.getfperm(file)    -- возвращаем строку с правами
      end
      table.insert(opts.sections.lualine_x, get_file_permissions)
    end,
  },
}
