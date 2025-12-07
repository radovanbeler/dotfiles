return {
	{
		"nvim-mini/mini.align",
		version = false,
		config = function()
			require("mini.align").setup()
		end,
	},
	{
		"nvim-mini/mini.trailspace",
		version = false,
		config = function()
			local trailspace = require("mini.trailspace")

			trailspace.setup()

			vim.keymap.set("n", "<leader>tt", function()
				trailspace.trim()
			end)

			vim.keymap.set("n", "<leader>tl", function()
				trailspace.trim_last_lines()
			end)
		end,
	},
}
