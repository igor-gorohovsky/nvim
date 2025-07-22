vim.api.nvim_set_hl(0, "Folded", {})
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "CursorLine", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#B10102" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarning", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarning", { undercurl = true })

vim.lsp.config("*", {
    capabilities = {
        positionEncodings = {'utf-8'},
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true
            }
        }
    },
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = nil
		end
	end,
})

vim.diagnostic.config({
    signs = false,
})

vim.lsp.enable({"basedpyright", "ruff", "lua_ls"})
