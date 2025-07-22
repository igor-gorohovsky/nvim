local map = vim.keymap.set

-- Common
map("n", "<leader>q", ":q<cr>")
map("n", "<leader>w", ":w<cr>")
vim.cmd([[cab wrap set wrap! \| set linebreak!]])

-- Telescope File and Vim pickers
local builtin = require("telescope.builtin")
local utils = require("utils.telescope")

map("n", "<leader>ff", utils.find_files)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fw", builtin.live_grep)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fr", builtin.registers)
map("n", "<leader>fk", builtin.keymaps)
map("n", "<leader>fj", builtin.jumplist)
map("n", "s", "<Nop>") -- no map to map with symbols search
map("n", "<leader>fs", utils.lsp_document_symbols)
map("n", "gr", builtin.lsp_references)
map("n", "gd", builtin.lsp_definitions)
map("n", "<leader>ld", vim.diagnostic.open_float)
map("n", "<leader>fd", builtin.diagnostics)

local hop = require("hop")
local directions = require("hop.hint").HintDirection
map("", "s", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR })
end, { remap = true })
map("", "S", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR })
end, { remap = true })

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

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<leader>ib", function()
	local breakpoint = { "breakpoint()" }
	vim.api.nvim_put(breakpoint, "l", true, true)
	vim.cmd("normal! ==")
end)
