-- Set git signs in the gutter, need to update topdelete
return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "-" },
            changedelete = { text = "~" },
        },
    },
}
