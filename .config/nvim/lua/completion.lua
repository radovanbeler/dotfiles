local luasnip = require("luasnip")
local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<A-y>"] = cmp.mapping.complete(),
		["<A-j>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<A-J>"] = cmp.mapping.select_next_item(),
		["<A-K>"] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = "nvim_lua", max_item_count = 10 },
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "path", max_item_count = 10 },
		{ name = "luasnip", max_item_count = 10 },
		{ name = "buffer", keyword_length = 5, max_item_count = 10 },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})

vim.keymap.set({ "i", "n" }, "<C-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "n" }, "<C-j>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true })