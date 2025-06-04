return {
    {
        "folke/noice.nvim",
        -- Classic commandline position instead of pop-up
        opts = {
            cmdline = {
                view = "cmdline" -- moves command line to bottom
            },
            presets = {
                -- tab completions for commandline don't pop-up at top
                command_palette = false,
                long_message_to_split = true
            }
        }
    }
}
