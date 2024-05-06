-- Git commands. Run :Git <whatever> like using the shell
return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]ummary" })
    end,
}
