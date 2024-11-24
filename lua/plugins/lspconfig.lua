return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = true,
				keymap = {
					manual_complete = "<M-l>",
					recommended = true,
				},
				completion = {
					always = false,
				},
			}
		end,
		config = function()
			require("config.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
}
