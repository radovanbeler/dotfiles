local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local events = require("luasnip.util.events")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

vim.treesitter.query.set(
    "cpp",
    "fixture_query",
    [[
    (class_specifier
      name: (type_identifier) @fixture
      (base_class_clause [
         (type_identifier) @base_class (#eq? base_class "Test")
         (qualified_identifier
           scope: (namespace_identifier) @scope (#eq? scope "testing")
           name: (type_identifier) @base_class (#eq? base_class "Test"))]))
    ]]
)

local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "cpp", {})
    local tree = parser:parse()
    return tree[1]:root()
end

local fixtures = function(index)
    return d(index, function()
        local bufnr = vim.api.nvim_get_current_buf()
        local root = get_root(bufnr)

        local fixtures = {}
        local query = vim.treesitter.query.get("cpp", "fixture_query")
        for id, node in query:iter_captures(root, bufnr, 0, -1) do
            local name = query.captures[id]
            if name == "fixture" then
                table.insert(fixtures, t(vim.treesitter.get_node_text(node, 0)))
            end
        end

        -- Return insert node if no fixtures were found
        if next(fixtures) ~= nil then
            return sn(nil, c(1, fixtures))
        else
            return sn(nil, i(1, "FixtureName"))
        end
    end)
end

return {
    s("cout", fmt([[std::cout << {} << std::endl;]], { i(1) })),
    s("couts", fmt([[std::cout << "{}" << std::endl;]], { i(1) })),
    s("mode", fmt([[{} % 2 == 0]], { i(1, "a") })),
    s("modo", fmt([[{} % 2 != 0]], { i(1, "a") })),
    s("modd", fmt([[{} % {} == 0]], { i(1, "a"), i(2, "b") })),
    s("modn", fmt([[{} % {} != 0]], { i(1, "a"), i(2, "b") })),
    s("main", {
        t({ "int main()", "{", "\t" }),
        i(1),
        t({ "", "", "\treturn 0;", "}" }),
    }),
    s("testf", {
        t("TEST_F ("),
        fixtures(1),
        t(", Test"),
        i(2, "Name"),
        t({ ")", "{", "\t" }),
        i(3),
        t({ "", "}" }),
    }),
}
