vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = "cp -r"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})

local show_marked_files = function()
	local buf = vim.api.nvim_create_buf(false, true)

	local marked_files = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	if type(marked_files) == "string" then
		marked_files = { marked_files[1] }
	end

	table.insert(marked_files, string.format("Press 'q' to continue"))

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, marked_files)

	vim.api.nvim_set_hl(0, "exitline", { fg = "#f6c177" })
	vim.api.nvim_buf_add_highlight(buf, -1, "exitline", #marked_files - 1, 0, -1)

	local width = vim.o.columns
	local height = #marked_files
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = vim.o.lines - height,
		col = vim.o.columns - width,
		style = "minimal",
		border = "none",
	})

	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "readonly", true)

	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q!<CR>", { noremap = true, silent = true })
end

vim.keymap.set("n", "ml", show_marked_files, { noremap = true, buffer = true })
vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true })
vim.keymap.set("n", "h", "-", { remap = true, buffer = true })
