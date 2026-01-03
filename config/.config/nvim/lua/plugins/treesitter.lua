return {
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
}
