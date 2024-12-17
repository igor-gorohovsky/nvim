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
		"echasnovski/mini.completion",
		version = "*",
		config = function(_, opts)
			opts = {
				mappings = { force_twostep = "<M-l>" },
				delay = { completion = 1000000, info = 1000000, signature = 1000000 }, -- set large values to disable auto completion
			}
			require("mini.completion").setup(opts)
		end,
	},
}
