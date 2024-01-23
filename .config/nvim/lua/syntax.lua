require('rose-pine').setup({
    styles = {
        bold = false,
        italic = false,
        transparency = false,
    },
})
vim.cmd("colorscheme rose-pine")

require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})

require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
    },
})
