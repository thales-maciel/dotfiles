return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer',

        -- schema information
        'b0o/schemaStore.nvim',

        -- cmp
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
        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        local lspconfig = require "lspconfig"

        local servers = {
            bashls = true,
            gopls = {
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            },
            lua_ls = true,
            rust_analyzer = true,
            html = true,
            cssls = true,
            tsserver = {
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true
                    },
                }
            },
            svelte = true,
            templ = true,
            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                    },
                },
            },
            -- pylyzer = true,
            basedpyright = true,
        }

        local servers_to_install = vim.tbl_keys(servers)

        local ensure_installed = {
            "html",
            "cssls",
            "gopls",
            "tsserver",
            "lua_ls",
            "rust_analyzer",
            "templ",
            "delve",
        }

        require("mason").setup()
        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }

        for name, config in pairs(servers) do
            if config == true then config = {} end
            config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
            lspconfig[name].setup(config)
        end

        local td = require("thales-maciel.diagnostics")

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function (_)
                local opts = { buffer = 0 }

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>lv", td.select_level, opts)
                vim.keymap.set("v", "<leader>lf", vim.diagnostic.open_float, opts)
                vim.keymap.set("v", "<leader>lj", vim.diagnostic.goto_next, opts)
                vim.keymap.set("v", "<leader>lk", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, opts)
                vim.keymap.set("v", "<leader>lr", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>li", function()
                    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
                end, opts)
            end
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

        -- vim.keymap.set("n", "<leader>mi", require('go.iferr').run)
        -- vim.keymap.set("n", "<leader>mfo", require('go.reftool').fillstruct)
        -- vim.keymap.set("n", "<leader>mfs", require('go.reftool').fillswitch)
        --
        --#endregion
        --#endregion

    end
}

