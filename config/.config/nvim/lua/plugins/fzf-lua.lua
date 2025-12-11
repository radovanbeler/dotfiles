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
				winopts = {
					height = 0.95,
					width = 0.95,
					on_create = function()
						vim.keymap.set("t", "<C-j>", "<Enter>", { silent = true, buffer = true })
					end,
				},
				fzf_opts = {
					["--layout"] = "reverse",
				},
			})

			vim.keymap.set("n", "<leader>ff", fzf.files)
			vim.keymap.set("n", "<leader>fa", function()
				local opts = "--color=never --type f --hidden --follow --no-ignore --exclude .git"
				fzf.files({ fd_opts = opts })
			end)
			vim.keymap.set("n", "<leader>fd", function()
				local opts = "--color=never --type d --hidden --follow --no-ignore --exclude .git"
				fzf.files({ fd_opts = opts })
			end)
			vim.keymap.set("n", "<leader>f/", fzf.live_grep)
			vim.keymap.set("n", "<leader>fr", fzf.lsp_references)
			vim.keymap.set("n", "<leader>fs", fzf.lsp_workspace_symbols)
			vim.keymap.set("n", "<leader>ft", fzf.treesitter)
			vim.keymap.set("n", "<leader>fh", fzf.helptags)
			vim.keymap.set("n", "<leader>fm", fzf.manpages)
		end,
	},
}
