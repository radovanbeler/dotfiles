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
	incremental_selection = {
		enable = true,
		keymaps = {
			-- set to `false` to disable one of the mappings
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
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
		swap = {
			enable = true,
			swap_next = {
				["gpn"] = "@parameter.inner",
				["gmn"] = "@function.outer",
			},
			swap_previous = {
				["gpp"] = "@parameter.inner",
				["gmp"] = "@function.outer",
			},
		},
	},
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = false,
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
