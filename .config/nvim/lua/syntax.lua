require("rose-pine").setup({
	styles = {
		bold = false,
		italic = false,
		transparency = false,
	},
})
vim.cmd("colorscheme rose-pine")

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

require("nvim-treesitter.configs").setup({
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
			},
			-- 'v' -> charwise, 'V' -> linewise, <c-v> -> blockwise
			selection_modes = {
				["@function.inner"] = "V",
				["@function.outer"] = "V",
				["@class.inner"] = "V",
				["@class.outer"] = "V",
			},
			include_surrounding_whitespace = false,
		},
	},
})

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})
