vim.o.termguicolors = true

vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.spelllang = "en"
vim.opt.spell = false

vim.g.mapleader = " "

local toggle_spellcheck = function()
	if vim.opt.spell:get() then
		vim.opt.spell = false
	else
		vim.opt.spell = true
	end
end

-- Spell options
vim.keymap.set("n", "<Leader>so", toggle_spellcheck)
vim.keymap.set("n", "<Leader>ss", function()
	vim.opt.spelllang = "sk"
end)
vim.keymap.set("n", "<Leader>se", function()
	vim.opt.spelllang = "en_us"
end)
-- Open Netrw
vim.keymap.set("n", "<Leader>pf", vim.cmd.Ex)
-- Paste over text in visual mode without losing content in register
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", ":G<CR>")
vim.keymap.set("n", "<leader>gp", ":G push<CR>")
-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Keep cursors at the begging of the line
vim.keymap.set("n", "J", "mzJ`z")
-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

require("Comment").setup({
	padding = true,
	sticky = true,
	ignore = nil,
	opleader = {
		line = "gc",
		block = "gb",
	},
	toggler = {
		line = "gcc",
		block = "gbc",
	},
	extra = {
		above = "gcO",
		below = "gco",
		eol = "gcA",
	},
	mappings = {
		basic = true,
		extra = true,
	},
	pre_hook = nil,
	post_hook = nil,
})

require("lualine").setup({
	options = {
		icons_enabled = false,
	},
	sections = {
		lualine_a = { "branch" },
		lualine_b = { "filename" },
		lualine_c = {},
		lualine_x = { "encoding" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
