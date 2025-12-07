vim.o.termguicolors = true

vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.updatetime = 50
vim.opt.mouse = ""
vim.opt.showmode = false
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.laststatus = 3
vim.opt.statusline = "%t %m%r %y%=[%l,%v] %p%%"

vim.opt.foldmethod = "expr"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.foldtext = ""
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
