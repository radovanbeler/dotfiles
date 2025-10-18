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

			local conf = require("telescope.config").values
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")

			vim.keymap.set("n", "<leader>fd", function()
				local finder_command = { "fdfind", "--type", "d", "--color", "never" }

				opts = opts or {}
				pickers
					.new(opts, {
						prompt_title = "Find Directories",
						finder = finders.new_oneshot_job(finder_command, {}),
						sorter = conf.generic_sorter(opts),
						layout_strategy = "center",
						layout_config = { width = 0.5, height = 0.75, prompt_position = "bottom" },
					})
					:find()
			end, {})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
