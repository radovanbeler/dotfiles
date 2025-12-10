return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local fzf = require("fzf-lua")

			fzf.setup({
				"telescope",
				defaults = {
					file_icons = false,
				},
				winopts = {
					height = 0.95,
					width = 0.95,
				},
			})

			vim.keymap.set("n", "<leader>ff", fzf.files)
			vim.keymap.set("n", "<leader>f/", fzf.live_grep)
			vim.keymap.set("n", "<leader>fa", function()
				fzf.files({ fd_opts = "--color=never --type f --hidden --follow --no-ignore" })
			end)
			vim.keymap.set("n", "<leader>fr", fzf.lsp_references)
			vim.keymap.set("n", "<leader>fs", fzf.lsp_workspace_symbols)
			vim.keymap.set("n", "<leader>ft", fzf.treesitter)
			vim.keymap.set("n", "<leader>fh", fzf.helptags)
			vim.keymap.set("n", "<leader>fm", fzf.manpages)
		end,
	},
}
