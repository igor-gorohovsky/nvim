local map = vim.keymap.set

-- Common
map("n", "<leader>q", ":q<cr>")
map("n", "s", "<Nop>") -- no map to map with symbols search

-- Neotree
map("n", "<leader>e", "<Cmd>Neotree position=float<CR>")

-- Telescope File and Vim pickers
local builtin = require("telescope.builtin")
map("n", "<leader><leader>", builtin.find_files)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fw", builtin.live_grep)
map("n", "<leader>fh", builtin.highlights)
map("n", "<leader>fr", builtin.registers)

-- Telescope LSP pickers

map("n", "ss", builtin.lsp_document_symbols)
map("n", "<leader>fd", builtin.diagnostics)

-- Hop
local hop = require("hop")
local directions = require("hop.hint").HintDirection
map("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
map("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
map("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
map("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- Comment
map("n", "<leader>/", "gcc")
map("v", "<leader>/", "gc")
