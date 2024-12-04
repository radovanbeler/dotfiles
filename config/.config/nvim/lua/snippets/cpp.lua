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
local fmta = require("luasnip.extras.fmt").fmta
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

vim.treesitter.query.set(
    "cpp",
    "regex_query",
    [[
    [
    (declaration
      type: (_) @type (#match? @type "(std::)?regex")
      declarator: (_
        declarator: (identifier) @identifier))
    (declaration
      type: (placeholder_type_specifier (auto)) @auto
      declarator: (_
        declarator: (identifier) @identifier
        value: (_ 
          type: (_) @type (#match? @type "(std::)?regex"))))
    ]
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

local contains = function(table, value)
    if not table then
        return false
    end

    for _, v in pairs(table) do
        if value == v then
            return true
        end
    end

    return false
end

local empty = function(table)
    return next(table) == nil
end

local up = function(types, node)
    if type(types) ~= "table" then
        types = { types }
    end

    node = node or vim.treesitter.get_node()
    while node ~= nil do
        if contains(types, node:type()) then
            break
        end
        node = node:parent()
    end

    return node
end

local nodes_in_scope = function(bufnr, root, query_name, captures)
    local query = vim.treesitter.query.get("cpp", query_name)
    if not query then
        return {}
    end

    local nodes = {}
    for id, node in query:iter_captures(root, bufnr) do
        local name = query.captures[id]
        if contains(captures, name) then
            table.insert(nodes, node)
        end
    end

    return nodes
end

local regex = function(index)
    return d(index, function()
        local node = up("function_definition")

        if node then
            local identifiers = {}
            local bufnr = vim.api.nvim_get_current_buf()
            local nodes = nodes_in_scope(bufnr, node, "regex_query", { "identifier" })
            for _, node in ipairs(nodes) do
                table.insert(identifiers, t(vim.treesitter.get_node_text(node, bufnr)))
            end

            if not empty(identifiers) then
                return sn(nil, c(1, identifiers))
            end
        end
        return sn(nil, i(1, "regex"))
    end)
end

return {
    s("cout", fmt([[std::cout << {} << std::endl;]], { i(1) })),
    s("couts", fmt([[std::cout << "{}" << std::endl;]], { i(1) })),
    s("mod", fmt([[{} % 2 {} 0]], { i(1, "a"), c(2, { t("=="), t("!=") }) })),
    s("testf", {
        t("TEST_F ("),
        fixtures(1),
        t(", Test"),
        i(2, "Name"),
        t({ ")", "{", "\t" }),
        i(3),
        t({ "", "}" }),
    }),
    s("regs", fmt([[std::regex_search({}, {}, {})]], { i(1, "string"), i(2, "match"), regex(3) })),
    s("main", {
        t({ "int main()", "{", "\t" }),
        i(1),
        t({ "", "", "\treturn 0;", "}" }),
    }),
    s("while", {
        t("while ("),
        i(1),
        t({ ")", "{", "\t" }),
        i(2),
        t({ "", "}", "" }),
        i(0),
    }),
    s("do", {
        t({ "do", "{", "\t" }),
        i(1),
        t({ "", "} while (" }),
        i(2),
        t({ ");", "" }),
        i(0),
    }),
    s("for", {
        t("for ("),
        i(1),
        t("; "),
        i(2),
        t("; "),
        i(3),
        t({ ")", "{", "\t" }),
        i(4),
        t({ "", "}", "" }),
        i(0),
    }),
    s("fore", {
        t("for ("),
        i(1),
        t(" : "),
        i(2),
        t({ ")", "{", "\t" }),
        i(3),
        t({ "", "}", "" }),
        i(0),
    }),
    s("if", {
        t("if ("),
        i(1),
        t({ ")", "{", "\t" }),
        i(2),
        t({ "", "}", "" }),
        i(0),
    }),
    s("elif", {
        t("else if ("),
        i(1),
        t({ ")", "{", "\t" }),
        i(2),
        t({ "", "}", "" }),
        i(0),
    }),
    s("else", {
        t({ "else", "{", "\t" }),
        i(1),
        t({ "", "}", "" }),
        i(0),
    }),
    s("switch", {
        t("switch ("),
        i(1),
        t({ ")", "{", "" }),
        i(2),
        t({ "", "}", "" }),
        i(0),
    }),
    s("case", {
        t("case "),
        i(1),
        t({ ":", "\t" }),
        i(2),
        t({ "" }),
        i(0),
    }),
    s("caseb", {
        t("case "),
        i(1),
        t({ ":", "\t" }),
        i(2),
        t({ "", "\tbreak;" }),
        i(0),
    }),
    s("default", {
        t({ "default:", "\t" }),
        i(1),
    }),
}
