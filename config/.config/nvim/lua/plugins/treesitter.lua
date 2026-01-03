return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ts.get_installed(),
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		branch = "main",
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner")
			end)
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer")
			end)

			local swap = require("nvim-treesitter-textobjects.swap")
			vim.keymap.set("n", "gpn", function()
				swap.swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "gpp", function()
				swap.swap_previous("@parameter.inner")
			end)
		end,
	},
}
