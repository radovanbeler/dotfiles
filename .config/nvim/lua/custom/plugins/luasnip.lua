return {
    "L3MON4D3/LuaSnip",
    priority = 100,
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "cpp" } })
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/custom/snippets" })

        luasnip.setup({
            update_events = { "TextChanged", "TextChangedI" },
            enable_autosnippets = true,
        })

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<c-l>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { silent = true })
    end,
}
