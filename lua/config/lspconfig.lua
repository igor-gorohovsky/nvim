local M = {}
local map = vim.keymap.set

-- -----------------------------------------------------------------------------

M.on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	if client.name == "ruff" then
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false
	end

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "<leader>ld", vim.diagnostic.open_float)
end

-- ------------------------------------------------------------------------------

M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
		-- client.server_capabilities.semanticTokensProvider = client.server_capabilities.semanticTokensProvider
	end
end

-- ------------------------------------------------------------------------------

-- M.capabilities = vim.tbl_deep_extend(
-- 	"force",
-- 	vim.lsp.protocol.make_client_capabilities(),
-- 	require("cmp_nvim_lsp").default_capabilities()
-- )
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- ------------------------------------------------------------------------------

M.defaults = function()
	require("lspconfig").lua_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					},
				},
			},
		},
	})
end

-- -----------------------------------------------------------------------------

M.defaults()
local lspconfig = require("lspconfig")
local default_servers = { "html", "cssls" }

for _, lsp in ipairs(default_servers) do
	lspconfig[lsp].setup({
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
	})
end

-- ------------------------------ Pyright --------------------------------------

lspconfig.basedpyright.setup({
	on_attach = M.on_attach,
	on_init = M.on_init,
	capabilities = M.capabilities,
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				diagnosticSeverityOverrides = {
					reportUnusedImport = "information",
					reportUnusedFunction = "information",
					reportUnusedVariable = "information",
					reportGeneralTypeIssues = "none",
					reportOptionalMemberAccess = "none",
					reportOptionalSubscript = "none",
					reportPrivateImportUsage = "none",
					reportTypedDictNotRequiredAccess = "none",
				},
			},
		},
	},
})

---------------------------------- Ruff ----------------------------------------

require("lspconfig").ruff.setup({
	on_attach = M.on_attach,
	on_init = M.on_init,
	capabilities = M.capabilities,
	init_options = {
		settings = {
			lineLength = 100,
		},
	},
})

--------------------------------- Lexical ------------------------------------
local util = require("lspconfig").util

require("lspconfig").lexical.setup({
	cmd = { "/home/igorohovsky/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
	root_dir = function(fname)
		return util.root_pattern("mix.exs", ".git")(fname) or vim.fn.getcwd()
	end,
	filetypes = { "elixir", "eelixir", "heex" },
	on_attach = M.on_attach,
	on_init = M.on_init,
	capabilities = M.capabilities,
})

-- -----------------------------------------------------------------------------

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = false,
})
