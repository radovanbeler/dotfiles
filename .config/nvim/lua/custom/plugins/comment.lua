return {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
        require("Comment").setup({
            padding = true,
            sticky = true,
            ignore = nil,
            opleader = {
                line = "gc",
                block = "gb",
            },
            toggler = {
                line = "gcc",
                block = "gbc",
            },
            extra = {
                above = "gcO",
                below = "gco",
                eol = "gcA",
            },
            mappings = {
                basic = true,
                extra = true,
            },
            pre_hook = nil,
            post_hook = nil,
        })
    end,
}
