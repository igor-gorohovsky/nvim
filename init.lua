require("config.lazy")
require("mappings")
require("theme")()

local api = vim.api

api.nvim_create_autocmd("VimEnter", { command = "Telescope workspaces" })
