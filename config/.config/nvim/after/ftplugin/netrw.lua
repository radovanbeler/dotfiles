vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = "cp -r"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})

vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true })
vim.keymap.set("n", "h", "-", { remap = true, buffer = true })
