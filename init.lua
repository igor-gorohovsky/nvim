require("config.lazy")
require("mappings")

local api = vim.api

api.nvim_create_autocmd("VimEnter", { command = "Telescope workspaces" })
