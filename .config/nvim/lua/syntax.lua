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

