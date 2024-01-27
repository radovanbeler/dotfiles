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

lspconfig.pyright.setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "pyright" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<A-j>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<A-J>"] = cmp.mapping.select_next_item(),
		["<A-K>"] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "path" },
		{ name = "luasnip", max_item_count = 10 },
		{ name = "buffer", keyword_length = 5 },
	},
})

require("mason").setup()
require("mason-lspconfig").setup()
