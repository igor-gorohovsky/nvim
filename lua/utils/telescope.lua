local M = {}
local builtin = require("telescope.builtin")

M.find_files = function(opts)
	return builtin.find_files({ hidden = true })
end

return M
