return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("config.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = {
					lsp_format = "first",
				},
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			local sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
			})
			local window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			}
			local mappings = cmp.mapping.preset.insert({
				["<M-l>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			})
			local completion = {
				autocomplete = false,
			}
			return { sources = sources, window = window, mapping = mappings, completion = completion }
		end,
	},
}
