local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf, remap = false }
		vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gdd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gdD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gdh", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gdf", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "gda", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gdn", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "gdp", vim.diagnostic.goto_prev, opts)
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "pyright", "clangd", "html" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end
