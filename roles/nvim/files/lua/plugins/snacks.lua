return {
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                sections = {
                    {
                        title = "Keymaps",
                        icon = " ",
                        padding = 1
                    },
                    {
                        section = "keys",
                        indent = 2,
                        gap = 1
                    }
                }
            },
            explorer = {
                focus = "input"
                -- Useful shortcuts:
                -- <leader>+e   - toggle window on/off
                -- ctrl+w       - move cursor to file explorer
                -- ctrl+l       - move cusor to main window
            },
            bigfile = {
                enabled = true
            },
            notifier = {
                wrap = true,
                timeout = 2500,
            }
        }
    }
}
