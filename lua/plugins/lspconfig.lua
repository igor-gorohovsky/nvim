return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"ms-jpq/coq_nvim",
		},
		lazy = false,
		init = function()
			vim.g.coq_settings = {
				auto_start = true,
				keymap = {
					recommended = true,
					pre_select = false,
					manual_complete = "<M-l>",
				},
				completion = {
					always = false,
				},
				clients = {
					buffers = {
						enabled = false,
					},
					registers = {
						enabled = false,
					},
					tmux = {
						enabled = false,
					},
					tabnine = {
						enabled = false,
					},
					tree_sitter = {
						enabled = false,
					},
				},
				display = {
					pum = {
						fast_close = true,
					},
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
