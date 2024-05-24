--LSP related stuff. Also depends on autocompletion lsp plugin
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local servers = {
            cmake = {},
            clangd = {},
            ansiblels = {},
            bashls = {},
            dockerls = {},
            docker_compose_language_service = {},
            jinja_lsp = {},
            jsonls = {},
            terraformls = {},
            yamlls = {},
            zls = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            pylsp = {
                pylsp = {
                    plugins = {
                        autopep8 = {
                            enabled = true,
                        },
                        pycodestyle = {
                            enabled = true,
                            maxLineLength = 80,
                            identSize = 4,
                            hangClosing = false,
                        },
                        pydocstyle = {
                            enabled = true,
                            convention = "pep257",
                        },
                        pylint = {
                            enabled = true,
                        },
                    },
                },
            },
            gopls = {},
            rust_analyzer = {},
        },

        require("mason").setup()
        local mason_lspconfig = require "mason-lspconfig"

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        local on_attach = function(_, bufnr)
            -- local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = bufnr, desc = "[R]e[n]ame"})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = bufnr, desc = "[C]ode [A]ction"})

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr, desc = "[G]oto [D]efinition"})
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {buffer = bufnr, desc = "[G]oto [R]eferences"})
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer = bufnr, desc = "[G]oto [I]mplementation"})
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {buffer = bufnr, desc = "Type [D]efinition"})
            vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, {buffer = bufnr, desc = "[D]ocument [S]ymbols"})
            vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, {buffer = bufnr, desc = "[W]orkspace [S]ymbols"})

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = bufnr, desc = "Hover Documentation"})
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {buffer = bufnr, desc = "Signature Documentation"})

            vim.api.nvim_buf_create_user_command(
                bufnr,
                "Format",
                function(_)
                    vim.lsp.buf.format()
                end,
                { desc = "Format current buffer with LSP" }
            )
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        mason_lspconfig.setup_handlers {
            function(server_name)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                }
            end,
        }
    end,
}
