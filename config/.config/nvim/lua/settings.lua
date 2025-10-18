vim.o.termguicolors = true

vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.updatetime = 50
vim.opt.mouse = ""
vim.opt.showmode = false

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

-- Don't change working directory after opening a file
vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = "cp -r"

-- Enable line numbers in netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})
