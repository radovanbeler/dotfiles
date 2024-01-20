vim.o.termguicolors = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.g.mapleader = ' '

-- Open Netrw
vim.keymap.set('n', '<Leader>pf', vim.cmd.Ex)
-- Paste over text in visual mode without losing content in register
vim. keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
    },
    pre_hook = nil,
    post_hook = nil,
})

