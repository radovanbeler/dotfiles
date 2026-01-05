return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		local detail = false
		local toggle_detail = function()
			detail = not detail
			if detail then
				oil.set_columns({ "icon", "permissions", "user", "group", "size", "mtime" })
			else
				oil.set_columns({ "icon" })
			end
		end

		oil.setup({
			keymaps = {
				["gd"] = {
					callback = toggle_detail,
				},
			},
		})

		vim.keymap.set("n", "-", vim.cmd.Oil)
	end,
}
