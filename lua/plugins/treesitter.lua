return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
		},
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts_extend = { "ensure_installed" },
		opts = {
			auto_install = vim.fn.executable("git") == 1 and vim.fn.executable("tree-sitter") == 1,
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
