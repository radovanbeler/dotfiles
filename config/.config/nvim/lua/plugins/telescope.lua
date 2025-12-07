return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.95,
						height = 0.95,
						preview_width = 0.5,
					},
				},
			})

			telescope.load_extension("fzf")

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = false, no_ignore = false })
			end)

			vim.keymap.set("n", "<leader>fa", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end)

			vim.keymap.set("n", "<leader>f/", builtin.live_grep)
			vim.keymap.set("n", "<leader>f*", builtin.grep_string)

			vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
			vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols)

			vim.keymap.set("n", "<leader>ft", builtin.treesitter)

			vim.keymap.set("n", "<leader>fm", function()
				builtin.man_pages({ sections = { "ALL" } })
			end)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
