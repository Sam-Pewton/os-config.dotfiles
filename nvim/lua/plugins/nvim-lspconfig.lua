-- LSP related stuff. Also depends on autocompletion lsp plugin
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-nvim-lsp",
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
            local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
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
