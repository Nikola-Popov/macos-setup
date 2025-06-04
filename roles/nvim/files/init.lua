-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- focus on the main window (i.e. the writable area) on nvim open (instead of the file explorer on the left side)
vim.schedule(function()
    local snacks = require("snacks")
    if snacks and snacks.explorer and snacks.explorer.open then
        snacks.explorer.open()
        vim.defer_fn(function()
            vim.cmd("wincmd l") -- Move focus to the right (editor)
        end, 0)
    end
end)

-- Auto-update all plugins on nvim open
vim.api.nvim_create_autocmd("VimEnter",{callback=function()require"lazy".update({show = false})end})
