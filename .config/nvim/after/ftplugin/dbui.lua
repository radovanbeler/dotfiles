local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "sql", {})
    local tree = parser:parse()
    return tree[1]:root()
end

local statement_under_cursor = function(bufnr)
    local root = get_root(bufnr)
    local node = vim.treesitter.get_node()

    -- Cursor not inside statement
    if node == root then
        return nil, nil
    end

    -- Find top level node
    while node:parent() ~= root do
        node = node:parent()
    end

    -- Make sure statement is found
    if node:type() ~= "statement" then
        return nil, nil
    end

    local start_row, start_column, _ = node:start()
    local end_row, end_column, _ = node:end_()

    local start = { row = start_row, column = start_column }
    local end_ = { row = end_row, column = end_column }

    return start, end_
end

local highlight = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ns = vim.api.nvim_create_namespace("SQLStatement")
    local start, end_ = statement_under_cursor(bufnr)

    -- Not inside statement, remove all highlights
    if not start and not end_ then
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        return
    end

    for line = start.row, end_.row do
        vim.api.nvim_buf_add_highlight(bufnr, ns, "CursorLine", line, 0, -1)
    end
end

local execute = function()
    local start, end_ = statement_under_cursor(bufnr)

    if not start and not end_ then
        return
    end

    local visual = vim.api.nvim_replace_termcodes("v", true, false, true)

    vim.fn.setcursorcharpos(start.row + 1, start.column + 1)
    vim.cmd("normal! " .. visual)
    vim.fn.setcursorcharpos(end_.row + 1, end_.column + 1)
    vim.fn.feedkeys(string.format("%c%c%c(DBUI_ExecuteQuery)", 0x80, 253, 83))
end

vim.api.nvim_create_user_command("SQLExecute", function()
    if vim.bo.filetype == "sql" then
        execute()
    end
end, {})

vim.keymap.set("n", "<Leader>ee", "<CMD>SQLExecute<CR>")

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = vim.api.nvim_create_augroup("SQLStatementGroup", { clear = true }),
    callback = function()
        if vim.bo.filetype == "sql" then
            highlight()
        end
    end,
})
