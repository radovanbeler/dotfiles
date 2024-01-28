require("conform").setup({
	formatters_by_ft = {
		python = { "isort", "ruff_format" },
		lua = { "stylua" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})
