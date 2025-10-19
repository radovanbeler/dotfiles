return {
	"shortcuts/no-neck-pain.nvim",
	tag = "v2.5.0",
	config = function()
		require("no-neck-pain").setup({
			width = 125,
			mappings = {
				enabled = true,
			},
			buffers = {
				right = {
					enabled = false,
				},
			},
		})
	end,
}
