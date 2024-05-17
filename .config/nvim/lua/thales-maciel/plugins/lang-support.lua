return {
    {
        -- Golang templ
        "Joe-Davidson1802/templ.vim"
    },
    {
        -- Justfile
        "NoahTheDuke/vim-just",
        event = { "BufReadPre", "BufNewFile" },
        ft = { "\\cjustfile", "*.just", ".justfile", "justfile" }
    },
    {
        -- Neovim dev support
        "folke/neodev.nvim",
        opts = {}
    },
}
