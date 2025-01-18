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
				javascript = { "prettierd", "prettier", stop_after_first = true },
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
			"lukas-reineke/cmp-under-comparator",
		},
		opts = function()
			local cmp = require("cmp")
			local compare = cmp.config.compare
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
			local comparators = {
				compare.offset,
				compare.exact,
				compare.score,
				compare.recently_used,
				require("cmp-under-comparator").under,
				compare.kind,
			}
			return {
				sources = sources,
				window = window,
				mapping = mappings,
				completion = completion,
				sorting = {
					priority_weight = 1,
					comparators = comparators,
				},
			}
		end,
	},
}
