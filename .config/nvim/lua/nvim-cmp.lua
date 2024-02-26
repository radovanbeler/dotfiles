local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
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
