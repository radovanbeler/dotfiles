return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").setup()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", function()
                builtin.find_files({ no_ignore = true })
            end, {})

            vim.keymap.set("n", "<leader>f/", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})
            vim.keymap.set("n", "<leader>fb", builtin.git_branches, {})
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
            vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
            vim.keymap.set("n", "<space>fe", "<CMD>Telescope file_browser<CR>", { noremap = true })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
    },
}
