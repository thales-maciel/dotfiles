return {
    {
        -- Colorscheme
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        opts = { transparent_mode = true },
        init = function ()
            vim.cmd([[colorscheme gruvbox]])
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },
    {
        -- Status line
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'location'}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    },
    {
        -- Auto shiftwidth and expandtab
        "tpope/vim-sleuth"
    },
    {
        -- Autopairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        -- Commenting
        "numToStr/Comment.nvim",
        opts = {}
    },
    {
        -- Indentation guides
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
    },
    {
        -- Dot repeat
        "tpope/vim-repeat"
    },
}
