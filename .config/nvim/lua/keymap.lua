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
-- Execute current file as Python script
vim.keymap.set("n", "<leader>ep", ":!python %<CR>")

vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>")