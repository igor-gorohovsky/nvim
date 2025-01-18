return {
	{
		"Shatur/neovim-session-manager",
		opts = function()
			local config = require("session_manager.config")
			local opts = {
				autoload_mode = { config.AutoloadMode.CurrentDir },
				open_for_directories = false,
			}

			return opts
		end,
	},
}
