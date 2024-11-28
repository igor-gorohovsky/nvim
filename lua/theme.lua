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
	error = "#B10102",
	indent = "#181A1D",
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
	hl(0, "Bracket", { fg = colors.red })

	hl(0, "Type", { fg = colors.blue })

	-- Treesitter Functions
	-- hl(0, "@function", { fg = colors.orange })
	hl(0, "@function.call", { link = "@disabledHl" })
	hl(0, "@function.method.call", { link = "@disabledHl" })
	hl(0, "@constructor", {})

	-- Treesitter brackets
	hl(0, "@punctuation.bracket", { link = "Bracket" })
	hl(0, "@punctuation.delimiter", { fg = colors.lgray })
	hl(0, "@punctuation.special", { link = "Bracket" })

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

	-- Treesitter string
	hl(0, "@string.escape", { link = "String" })

	-- Indent char
	hl(0, "Indent", { fg = colors.indent })

	-- Lua specific
	hl(0, "@variable.lua", { link = "@disabledHl" })
	hl(0, "@property.lua", { link = "@disabledHl" })
	hl(0, "@constructor.lua", { link = "Bracket" })
	hl(0, "luaTable", { link = "Bracket" })
	hl(0, "luaParen", { link = "Bracket" })
	hl(0, "luaFunc", { link = "Function" })

	-- Python specific
	hl(0, "@constant.builtin.python", { link = "Constant" })
	hl(0, "@attribute.python", {})
	hl(0, "@type.definition.python", { link = "Type" })

	-- Bash specific
	hl(0, "@variable.parameter.bash", { link = "String" })

	-- Dockerfile specific
	hl(0, "@property.dockerfile", { link = "@disableHl" })

	-- Yaml specific
	hl(0, "@property.yaml", { link = "Keyword" })
	hl(0, "@property.dockerfile", { link = "@disableHl" })

	-- Diagnostic
	-- hl(0, "DiagnosticFloatingError", { fg = colors.error })
	hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
	--

	-- Telescope
	hl(0, "TelescopeMultiSelection", { fg = colors.yellow })
end
return highlight
