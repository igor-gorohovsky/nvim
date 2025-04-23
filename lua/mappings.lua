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

map("n", "<leader>ff", utils.find_files)
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

-- Harpoon mappings
local harpoon = require("harpoon")
map("n", "mm", function()
	harpoon:list():add()
end)
map("n", "<leader><leader>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
harpoon:extend({
	UI_CREATE = function(cx)
		vim.keymap.set("n", "<C-v>", function()
			harpoon.ui:select_menu_item({ vsplit = true })
		end, { buffer = cx.bufnr })

		vim.keymap.set("n", "<C-x>", function()
			harpoon.ui:select_menu_item({ split = true })
		end, { buffer = cx.bufnr })

		vim.keymap.set("n", "<C-t>", function()
			harpoon.ui:select_menu_item({ tabedit = true })
		end, { buffer = cx.bufnr })
	end,
})
-- LSP symbol rename
map("n", "<leader>lr", vim.lsp.buf.rename)
