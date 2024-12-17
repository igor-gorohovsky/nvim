return {
	{
		"Shatur/neovim-session-manager",
		opts = function(_, opts)
			local config = require("session_manager.config")
			opts = opts or {}
			local updated_opts = {
				autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.LastSession },
			}

			for k, v in pairs(updated_opts) do
				opts[k] = v
			end
			return opts
		end,
	},
}
