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
					jump_to_mark = "<Nop>",
					recommended = false,
				},
				completion = {
					always = false,
				},
			}
		end,
		config = function()
			require("config.lspconfig")
			require("config.coq")
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
}
