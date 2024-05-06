-- Status bar, :help feline.txt
return {
    "freddiehaddad/feline.nvim",
    opts = {},
    config = function(_, opts)
        require("feline").setup()
        -- require("feline").winbar.setup()
        require("feline").statuscolumn.setup()
    end,
}
