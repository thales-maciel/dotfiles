return {
    {
        -- harpoon
        'theprimeagen/harpoon',
        config = function ()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "_a", function() mark.add_file() print("added to harpoon") end)
            vim.keymap.set("n", "_e", ui.toggle_quick_menu)

            vim.keymap.set("n", "_h", function() ui.nav_file(1) print("Harpoon 1") end)
            vim.keymap.set("n", "_j", function() ui.nav_file(2) print("Harpoon 2") end)
            vim.keymap.set("n", "_k", function() ui.nav_file(3) print("Harpoon 3") end)
            vim.keymap.set("n", "_l", function() ui.nav_file(4) print("Harpoon 4") end)
        end
    },
    {
        -- easy alignment
        "junegunn/vim-easy-align"
    },
    {
        -- stdlib
        'nvim-lua/plenary.nvim',
    },
    {
        -- toggle join
        'Wansmer/treesj',
        keys = { '<leader>j', '<leader>J' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function ()
            local tj = require('treesj')

            tj.setup({
                use_default_keymaps = false,
                check_syntax_error = false,
                max_join_length = 120,
                cursor_behavior = 'hold',
                notify = true,
                dot_repeat = true,
                on_error = nil,
            })

            local recursive = function ()
                tj.toggle({ split = { recursive = true } })
            end

            vim.keymap.set('n', '<leader>j', tj.toggle)
            vim.keymap.set('n', '<leader>J', recursive)
        end
    },
    {
        -- telescope
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function ()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            telescope.load_extension('fzf')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,
                        }
                    }
                }
            })

            local builtin = require('telescope.builtin')
            local themes = require('telescope.themes')

            local function find_files() builtin.find_files({ hidden = true, theme = themes.get_dropdown()}) end
            local function git_files() builtin.git_files({ hidden = true, theme = themes.get_dropdown()}) end
            local function live_grep() builtin.live_grep(themes.get_dropdown()) end
            local function grep_string() builtin.grep_string(themes.get_dropdown()) end
            local function recent_files() builtin.oldfiles({ hidden = true, theme = themes.get_dropdown()}) end
            local function keymaps() builtin.keymaps(themes.get_dropdown()) end
            local function buffers() builtin.buffers(themes.get_dropdown()) end

            vim.keymap.set('n', '<leader>f', find_files, {})
            vim.keymap.set('n', '<leader>sf', git_files, {})
            vim.keymap.set('n', '<leader>sg', git_files, {})
            vim.keymap.set('n', '<leader>sr', recent_files, {})
            vim.keymap.set('n', '<leader>st', live_grep, {})
            vim.keymap.set('n', '<leader>sw', grep_string, {})
            vim.keymap.set('n', '<leader>sk', keymaps, {})
            vim.keymap.set('n', '<leader>sb', buffers, {})
        end
    },
    {
        -- easy surrounding
        "tpope/vim-surround"
    },
    {
        -- Match statement pairs
        'andymass/vim-matchup',
        setup = function ()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end
    }
}
