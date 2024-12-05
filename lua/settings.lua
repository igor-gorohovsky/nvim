local o = vim.o
local g = vim.g
local api = vim.api

o.expandtab = true
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4

o.relativenumber = true
o.termguicolors = true
o.laststatus = 0
o.clipboard = "unnamedplus"
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.cursorline = true

g.mapleader = " "

vim.wo.wrap = false

-- Show cursorline only in current window
api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	callback = function()
		o.cursorline = true
	end,
})
api.nvim_create_autocmd({ "WinLeave" }, {
	callback = function()
		o.cursorline = false
	end,
})

-- Create blank hl group for indent plugin
vim.api.nvim_set_hl(0, "Indent", {})
