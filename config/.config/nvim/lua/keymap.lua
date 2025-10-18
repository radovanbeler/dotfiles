-- Set leader key
vim.g.mapleader = " "

-- Open Netrw
vim.keymap.set("n", "<Leader>pf", vim.cmd.Ex)

-- Save file
vim.keymap.set("n", "<Leader>s", "<CMD>:w<CR>")

-- Paste over text in visual mode without losing content in register
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>gs", ":G<CR>")
vim.keymap.set("n", "<leader>gp", ":G push<CR>")

-- Move lines selected in visual-line mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered during half-screen scrolling
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")

-- Keep cursors at the begging of the line
vim.keymap.set("n", "J", "mzJ`z")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Make working with splits easier
vim.keymap.set("n", "<leader>w", "<C-w>")

-- Allows exiting a read-only buffer by pressing q. This remaps macros that are
-- rarely (never) used in a read-only buffer. Setting the buffer option to true
-- limits the mapping to the current buffer, so it is removed automatically
-- when exiting the buffer.
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buf = vim.api.nvim_win_get_buf(0)
		if vim.bo[buf].readonly then
			vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
		end
	end,
})
