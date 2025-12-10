-- Set leader key
vim.g.mapleader = " "

--------------------------------------------------------------------------------
-- Netrw
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>nn", vim.cmd.Explore)
vim.keymap.set("n", "<leader>nr", vim.cmd.Rexplore)

vim.keymap.set("n", "<leader>ns", function()
	vim.ui.input({ prompt = "Enter SSH host: " }, function(input)
		if not input then
			return
		end

		local host, path = input:match("^([^/]+)(.*)$")

		if not host or host:match("^%s*$") then
			return
		end

		if not path then
			path = "/"
		elseif not path:match("/%s*$") then
			path = path .. "/"
		end

		vim.cmd.Explore("scp://" .. host .. path)
	end)
end)

--------------------------------------------------------------------------------
-- Tabs
--------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>to", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnext)
vim.keymap.set("n", "<leader>tp", vim.cmd.tabprevious)

--------------------------------------------------------------------------------

-- Save file
vim.keymap.set("n", "<leader>s", "<CMD>:w<CR>")

-- Paste over text in visual mode without losing content in register
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("x", "<leader>P", '"+p')

-- Move lines selected in visual-line mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered during half-screen scrolling
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")

-- Keep cursor centered when moving through paragraphs
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Keep cursors at the begging of the line
vim.keymap.set("n", "J", "mzJ`z")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Jump to the end of the line
vim.keymap.set("i", "<c-e>", "<End>")

-- Remove color escape codes
vim.keymap.set("n", "<leader>tc", ":%s/\\e\\[[0-9;]*m//g<CR>")

-- Toggle semicolon at the end of line
vim.keymap.set("n", "<leader>;", function()
	local line = vim.api.nvim_get_current_line()
	local content, whitespace = line:match("^(.-)(%s*)$")

	if content:match(";$") then
		content = content:sub(1, -2)
	else
		content = content .. ";"
	end

	vim.api.nvim_set_current_line(content .. whitespace)
end)

vim.api.nvim_create_user_command("ClearReg", function()
	vim.cmd([[
        let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
        for r in regs
          call setreg(r, [])
        endfor
        wshada!
    ]])
end, {})

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
