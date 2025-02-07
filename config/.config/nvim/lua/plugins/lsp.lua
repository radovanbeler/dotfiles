return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local opts = { buffer = args.buf, remap = false }
				vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "<leader>dh", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>da", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "<leader>s", "<CMD>ClangdSwitchSourceHeader<CR>", opts)
			end,
		})

		local servers = { "pyright", "cmake" }
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
			})
		end
	end,
}
