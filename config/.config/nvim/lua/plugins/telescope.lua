return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup()
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = false, no_ignore = false })
			end, {})

			vim.keymap.set("n", "<leader>fa", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end, {})

			vim.keymap.set("n", "<leader>f/", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
