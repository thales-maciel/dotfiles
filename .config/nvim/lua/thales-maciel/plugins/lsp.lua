return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        { 'L3MON4D3/LuaSnip', tag = "v2.*" },
        'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
        -- #region cmp
        local cmp = require('cmp')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {},
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-k>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'cmdline' },
                { name = 'buffer' },
            }
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = true,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            }
        })
        -- #endregion cmp

        -- #region lsp
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'html',
                'cssls',
                'gopls',
                'tsserver',
                'lua_ls',
                'rust_analyzer',
                'templ',
                'eslint'
            },
            handlers = {
                function (server)
                    require('lspconfig')[server].setup({
                        capabilities = capabilities,
                    })
                end,
                ["eslint"] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig["eslint"].setup({
                        capabilities = capabilities,
                        -- cmd = { "fnm" , "use", "21", "&&", "vscode-eslint-language-server", "--stdio"}
                        -- settings = {
                        --     eslint = {
                        --         codeAction = {
                        --             disableRuleComment = {
                        --                 enable = true,
                        --                 location = "separateLine"
                        --             },
                        --             showDocumentation = {
                        --                 enable = true
                        --             }
                        --         },
                        --         codeActionOnSave = {
                        --             enable = false,
                        --             mode = "all"
                        --         },
                        --         experimental = {
                        --             useFlatConfig = false
                        --         },
                        --         format = true,
                        --         nodePath = "",
                        --         onIgnoredFiles = "off",
                        --         problems = {
                        --             shortenToSingleLine = false
                        --         },
                        --         quiet = false,
                        --         rulesCustomizations = {},
                        --         run = "onType",
                        --         useESLintClass = false,
                        --         validate = "on",
                        --         workingDirectory = {
                        --             mode = "location"
                        --         }
                        --     }
                        -- }
                    })
                end,
                ["rust_analyzer"] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig["rust_analyzer"].setup({
                        capabilities = capabilities,
                        settings = {
                            ["rust_analyzer"] = {}
                        }
                    })
                end,
                ["gopls"] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                usePlaceholders = true,
                                analyses = {
                                    unusedparams = true,
                                    unusedresult = true,
                                    unusedwrite = true,
                                },
                            }
                        }
                    })
                end,
                ["lua_ls"] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {'vim'},
                                },
                                workspace = {
                                    checkThirdParty = "Disable",
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config")] = true,
                                    }
                                },
                                hint = {
                                    enable = true,
                                    arrayIndex = "Disable",
                                    await = true,
                                    paramName = "All",
                                    paramType = true,
                                    semicolon = "All",
                                    setType = false,
                                }
                            }
                        }
                    })
                end
            }
        })
        -- #endregion lsp

        -- #region luasnip
        local ls = require('luasnip')
        local types = require('luasnip.util.types')
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local fmt = require('luasnip.extras.fmt').fmt
        local rep = require('luasnip.extras').rep

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "<-", "Error" } }
                    }
                }
            }
        })

        vim.keymap.set({ "i", "s" }, "<C-l>", function () ls.expand_or_jump() end, { silent = false })
        vim.keymap.set({ "i", "s" }, "<C-h>", function () ls.jump(-1) end, { silent = false })

        ls.add_snippets("all", {
            s("fn", {
                t("-- Parameters")
            })
        })

        ls.add_snippets("lua", {
            s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) }))
        })

        -- #endregion luasnip

        --#region Magic
        --#region GO

        vim.keymap.set("n", "<leader>mi", require('go.iferr').run)
        vim.keymap.set("n", "<leader>mfo", require('go.reftool').fillstruct)
        vim.keymap.set("n", "<leader>mfs", require('go.reftool').fillswitch)

        --#endregion
        --#endregion

    end
}

