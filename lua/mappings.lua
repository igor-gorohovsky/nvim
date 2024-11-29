local map = vim.keymap.set

-- Common
map("n", "<leader>q", ":q<cr>")
map("n", "<leader>w", ":w<cr>")
map("n", "s", "<Nop>") -- no map to map with symbols search

-- Neotree
map("n", "<leader>e", "<Cmd>Neotree position=float<CR>")
map("n", "<leader>r", "<Cmd>Neotree reveal position=float<cr>")

-- Telescope File and Vim pickers
local builtin = require("telescope.builtin")
local utils = require("utils.telescope")

map("n", "<leader><leader>", utils.find_files)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fw", builtin.live_grep)
map("n", "<leader>fh", builtin.highlights)
map("n", "<leader>fr", builtin.registers)
map("n", "<leader>fk", builtin.keymaps)
map("n", "<leader>fj", builtin.jumplist)
map("n", "<leader>fs", "<cmd>SessionManager load_session<cr>")

-- Telescope LSP pickers
map("n", "ss", utils.lsp_document_symbols)
map("n", "gr", builtin.lsp_references)
map("n", "<leader>fd", builtin.diagnostics)
map("n", "<leader>fW", "<cmd>Telescope workspaces<cr>")

-- LSP symbol rename
map("n", "<leader>lr", vim.lsp.buf.rename)

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
