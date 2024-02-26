require("conform").setup({
	formatters_by_ft = {
		python = { "isort", "ruff_format" },
		c = { "clang_format" },
		lua = { "stylua" },
		yaml = { "yamlfmt" },
		html = { "prettier" },
		css = { "prettier" },
		javascript = { "prettier" },
	},
	formatters = {
		clang_format = {
			prepend_args = { "-style=file" },
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})
