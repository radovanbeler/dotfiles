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

-- Misc keymaps
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>ep", ":!python %<CR>")
vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>")
vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
vim.keymap.set("n", "<leader>rr", "<CMD>Rest run<cr>")

-- Open header file with same filename as the current buffer
vim.keymap.set("n", "<leader>oh", function()
	local filename = vim.fn.expand("%")
	if filename == "" or string.find(filename, "%.cpp") == nil then
		return
	end
	local header = string.gsub(filename, "%.cpp", ".h")
	vim.cmd(":botright vsplit " .. header)
end)

-- gdbus call --session --dest org.gnome.Shell --object-path /me/madhead/Shyriiwook --method me.madhead.Shyriiwook.activate "sk+qwerty"
