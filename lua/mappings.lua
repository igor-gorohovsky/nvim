local map = vim.keymap.set

-- Common
map("n", "<leader>q", ":q<cr>")
map("n", "<leader>w", ":w<cr>")
map("n", "s", "<Nop>") -- no map to map with symbols search
vim.cmd([[cab wrap set wrap! \| set linebreak!]])

-- Neotree
-- map("n", "<leader>e", "<Cmd>Neotree <cr>")
-- map("n", "<leader>r", "<Cmd>Neotree reveal <cr>")

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
map("n", "gd", builtin.lsp_definitions)
map("n", "<leader>fd", builtin.diagnostics)

-- LSP symbol rename
map("n", "<leader>lr", vim.lsp.buf.rename)
