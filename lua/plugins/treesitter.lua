return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		cmd = {
			"TSBufEnable",
			"TSBufDisable",
			"TSBufToggle",
			"TSEnable",
			"TSDisable",
			"TSToggle",
			"TSConfigInfo",
			"TSEditQuery",
			"TSEditQueryUserAfter",
		},
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		opts_extend = { "ensure_installed" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"python",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"xml",
				"yaml",
				"toml",
			},
			textobjexts = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
