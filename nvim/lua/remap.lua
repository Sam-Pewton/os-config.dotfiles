-- All remapping for the default config (no plugins)

-- Set the leader key to be <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", { silent = true })

-- Open the explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew" })

-- Double <C-c> to apply changes to all lines selected
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Diagnostic keymap
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
