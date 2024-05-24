return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            sh = { "shellcheck" },
        }

        vim.api.nvim_create_autocmd({ "TextChanged" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
