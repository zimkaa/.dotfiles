return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            markdown = { "markdownlint-cli2", "markdown-toc" },
            python = { "ruff_organize_imports", "ruff_format" },
        },
        formatters = {
            ["markdownlint-cli2"] = {
                -- Заставляем работать, даже если нет файла конфигурации
                condition = function()
                    return true
                end,
            },
            ["markdown-toc"] = {
                -- markdown-toc требует наличия специального комментария в файле
                -- чтобы знать, куда вставлять оглавление.
                condition = function()
                    return true
                end,
            },
        },
    },
}
