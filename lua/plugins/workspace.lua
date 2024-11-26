return {
	{
		"natecraddock/workspaces.nvim",
		opts = function(_, opts)
			require("workspaces").setup()
		end,
	},
}
