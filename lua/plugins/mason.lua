return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local custom_lspconfig = require("config.lspconfig")
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"basedpyright",
			},
		})
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_init = custom_lspconfig.on_init,
					on_attach = custom_lspconfig.on_attach,
					capabilities = custom_lspconfig.capabilities,
				})
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
					on_init = custom_lspconfig.on_init,
					on_attach = custom_lspconfig.on_attach,
					capabilities = custom_lspconfig.capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
		})

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.mypy.with({
					extra_args = function()
						local virtual_env = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
						return { "--python-executable", virtual_env .. "/bin/python3" }
					end,
				}),
			},
		})
	end,
}
