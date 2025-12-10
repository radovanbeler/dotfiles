local fzf = require("fzf-lua")
local visits = require("mini.visits")

local relative_path = function(path)
	local cwd = vim.fn.getcwd()
	cwd = cwd:sub(-1) == "/" and cwd or (cwd .. "/")
	return vim.startswith(path, cwd) and path:sub(cwd:len() + 1) or vim.fn.fnamemodify(path, ":~")
end

local is_file = function(path_data)
	local stat = vim.uv.fs_stat(path_data.path)
	if stat then
		return stat.type == "file"
	end
	return false
end

local recent_visits = function()
	local sort_recent = visits.gen_sort.default({ recency_weight = 1 })
	local paths = visits.list_paths(nil, {
		filter = is_file,
		sort = sort_recent,
	})
	return vim.tbl_map(relative_path, paths)
end

vim.keymap.set("n", "<leader>v", function()
	local paths = recent_visits()
	local width = vim.api.nvim_win_get_width(0)
	fzf.fzf_exec(paths, {
		winopts = {
			height = 0.4,
			width = 80 / width,
			row = 0.2,
		},
		actions = {
			default = function(selected, _)
				vim.cmd.edit(selected)
			end,
		},
		fzf_opts = {
			["--layout"] = "reverse",
		},
	})
end)
