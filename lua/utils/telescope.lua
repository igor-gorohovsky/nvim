local M = {}
local builtin = require("telescope.builtin")

M.find_files = function(opts)
	return builtin.find_files({ hidden = true, no_ignore = true })
end

M.lsp_document_symbols = function(opts)
	return builtin.lsp_document_symbols({
		ignore_symbols = { "variable" },
	})
end
return M
