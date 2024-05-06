-- All remapping for the default config (no plugins)

-- Set the leader key to be <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Open the explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew" })

-- Double <C-c> to apply changes to all lines selected
vim.keymap.set("i", "<C-c>", "<Esc>")
