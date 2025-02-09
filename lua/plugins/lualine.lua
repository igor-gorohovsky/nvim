return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        opts = {
            options = {
                theme = "pustota"
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {},
                lualine_c = {"filename"},
                lualine_x = {"location"},
                lualine_y = {},
                lualine_z = {}
            },
        }
        require("lualine").setup(opts)
    end,
}
