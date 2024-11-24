local hl = vim.api.nvim_set_hl
local colors = {
	black = "#0A0E14",
	gray = "#B3B1AD",
	lgray = "#B9B9B9",
	yellow = "#E6B450",
	orange = "#FFB454",
	red = "#FF8F40",
	blue = "#59C2FF",
	comment = "#626A73",
	string = "#C2D94C",
}

local highlight = function()
	-- Custom group
	hl(0, "@disabledHl", { fg = colors.lgray })

	-- Common
	hl(0, "Normal", { fg = colors.gray, bg = colors.black })
	hl(0, "Comment", { fg = colors.comment, italic = true })

	hl(0, "String", { fg = colors.string })
	hl(0, "Character", { fg = colors.string })

	hl(0, "Constant", { fg = colors.yellow })
	hl(0, "Special", { link = "@disabledHl" })

	hl(0, "Function", { fg = colors.orange })

	hl(0, "Operator", { fg = colors.red })
	hl(0, "Keyword", { fg = colors.red })
	hl(0, "Exception", { fg = colors.red })
	hl(0, "Conditional", { fg = colors.red })
	hl(0, "Label", { fg = colors.red })
	hl(0, "Repeat", { fg = colors.red })
	hl(0, "Statement", { fg = colors.red })

	hl(0, "Type", { fg = colors.blue })

	-- Treesitter Functions
	-- hl(0, "@function", { fg = colors.orange })
	hl(0, "@function.call", { link = "@disabledHl" })
	hl(0, "@function.method.call", { link = "@disabledHl" })
	hl(0, "@constructor", { link = "Function" })

	-- Treesitter brackets
	hl(0, "@punctuation.bracket", { fg = colors.red })
	hl(0, "@punctuation.delimiter", { fg = colors.lgray })

	-- Treesitter variables
	hl(0, "@variable", { link = "@disabledHl" })
	hl(0, "@variable.parameter", { link = "@disabledHl" })
	hl(0, "@variable.builtin", { link = "@disabledHl" })
	hl(0, "@variable.member", { link = "@disabledHl" })

	-- Treesitter modules
	hl(0, "@module", { link = "@disabledHl" })
	hl(0, "@module.builtin", { link = "@disabledHl" })

	-- Treesitter const
	hl(0, "@constant", { link = "@disabledHl" })
	hl(0, "@constant.builtin", { link = "Constant" })

	-- Treesitter class
	hl(0, "@type", { link = "@disabledHl" })
	hl(0, "@type.definition", { link = "Type" })

	-- Lua specific
	hl(0, "@variable.lua", { link = "@disabledHl" })
	hl(0, "@property.lua", { link = "@disabledHl" })
	hl(0, "@constructor.lua", { link = "@punctuation.bracket" })

	-- Python specific
	hl(0, "@constant.builtin.python", { link = "Constant" })
	hl(0, "@attribute.python", { link = "Operator" })
end
return highlight
