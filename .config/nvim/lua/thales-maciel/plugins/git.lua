return {
    {
        "f-person/git-blame.nvim",
        config = function ()
            require("gitblame").setup({
                enabled = false,
            })
            vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', {})
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gk', require('gitsigns').prev_hunk, { buffer = bufnr })
                vim.keymap.set('n', '<leader>gj', require('gitsigns').next_hunk, { buffer = bufnr })
                vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr })
            end,
        },
    },
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>gg", "<cmd>LazyGit<CR>"}
        }
    }
}
