-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Swap `;` and `:` behavior
map("n", ";", ":", { noremap = true, silent = false })
map("n", ":", ";", { noremap = true, silent = false })

-- Command-line mode: Remap 'q' to 'qa' and it's variations
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function()
        vim.cmd.cnoreabbrev("q", "qa")
        vim.cmd.cnoreabbrev("q!", "qa!")
        vim.cmd.cnoreabbrev("wq", "wqa")
        vim.cmd.cnoreabbrev("wq!", "wqa!")
    end,
})