return {
	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
		opts = function(opts)
			local keymaps = {
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-x>"] = { "actions.select", opts = { horizontal = true } },
			}
			opts = vim.tbl_deep_extend("force", opts, { keymaps = keymaps })
			return opts
		end,
		config = function(opts)
			local oil = require("oil")

			vim.keymap.set("n", "<leader>e", oil.toggle_float)

			oil.setup(opts)
		end,
	},
}
