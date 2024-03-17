-- Toggle spellcheck
vim.keymap.set("n", "<Leader>sc", function()
	vim.opt.spell = not vim.opt.spell:get()
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

vim.keymap.set("n", "<leader>ep", ":!python %<CR>")
vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>")
vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)

vim.keymap.set("n", "<leader>w", "<C-w>")

function print_lines()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local file = assert(io.open("sinep", "w"))
	file:write(table.concat(lines, "\n"))
	file:close()
end

vim.keymap.set("n", "<leader>ec", print_lines)
