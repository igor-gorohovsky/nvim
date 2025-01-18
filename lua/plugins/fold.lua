local ftMap = {}
return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			local providers = ftMap[filetype]
			if providers == nil then
				return { "treesitter", "indent" }
			else
				return providers
			end
		end,
		close_fold_kinds_for_ft = {
			default = { "imports", "comments" },
		},
	},
	config = function(_, opts)
		local ufo = require("ufo")

		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)

		ufo.setup(opts)
	end,
}
