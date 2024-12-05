return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
				highlight = "Indent",
			},
			scope = {
				enabled = false,
			},
		},
		config = function(_, opts)
			require("pustota").ibl_setup()
			require("ibl").setup(opts)
		end,
	},
}
