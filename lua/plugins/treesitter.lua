return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = {
								query = "@function.outer",
								desc = "Select outer part of a method/function definition",
							},
							["if"] = {
								query = "@function.inner",
								desc = "Select inner part of a method/function definition",
							},

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
							["<leader>nf"] = "@function.outer", -- swap function with next
							["<leader>nc"] = "@class.outer",
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
							["<leader>pf"] = "@function.outer", -- swap function with previous
							["<leader>pc"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
}
