return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 4 -- Filename and parent dir, with tilde as the home directory
                    }
                },
                lualine_z = {}
            }
        end
    }
}
