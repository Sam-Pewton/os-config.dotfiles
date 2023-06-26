vim.g.mapleader = " "

-- open the explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move highlighted lines up and down 
vim.keymap.set("v", "J", ":m '>+0<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the same place or in the middle when searching, moving, and modifying
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete selection into void register when pasting
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- clipboard.. doesnt work as no clipboard set
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- double ctrlc to apply changes to all lines selected
vim.keymap.set("i", "<C-c>", "<Esc>")

-- replace word currently hovering over
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent  = true })

