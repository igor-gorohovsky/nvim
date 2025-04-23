local M = {}
local builtin = require("telescope.builtin")

local conf = require("telescope.config").values
M.list_harpoon_marks = function(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

M.find_files = function(opts)
	return builtin.find_files({ hidden = true, no_ignore = true })
end

M.lsp_document_symbols = function(opts)
	return builtin.lsp_document_symbols({
		ignore_symbols = { "variable" },
	})
end
return M
