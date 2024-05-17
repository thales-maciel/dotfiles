return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-context' },
        { 'nvim-treesitter/playground' },
    },
    config = function ()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "go",
                "rust",
                "javascript",
                "typescript",
                "html",
                "java",
                "json",
                "markdown",
                "nix",
                "sql",
                "yaml",
                "toml",
                "scss",
                "python",
                "ocaml",
                "haskell",
                "git_config",
                "dockerfile",
                "bash",
            },

            modules = {},
            sync_install = true,
            auto_install = true,
            ignore_install = {},

            matchup = {
                enable = true,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "H",
                    scope_incremental = "_",
                    node_decremental = "L",
                },
            },

            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = false,
            },

            indent = { enable = true },
        }
    end
}
