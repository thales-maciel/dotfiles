return {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 450
    end,
    opts = { ignore_missing = true },
    config = function ()
        local wk = require("which-key")

        wk.register({
            [":"] = { "Dashboard" },
            e = { "Explorer" },
            w = { "Write" },
            c = { "Close" },
            q = { "Quit" },

            f = { "Files" },

            d = {
                name = "Debug",
                L = { "Continue" },
                h = { "Step back" },
                k = { "Step out" },
                j = { "Step into" },
                l = { "Step over" },
                C = { "Run to cursor" },
                e = { "Eval under cursor" },
                E = { "Eval expression" },
                r = { "Open repl" },
                t = { "Toggle breakpoint" },
                T = { "Set conditional breakpoint" },
                p = { "Pause" },
                U = { "Toggle UI" },
                x = { "Terminate" },
            },

            g = {
                name = "Git",
                j = { "Go to next hunk" },
                k = { "Go to previous hunk" },
                p = { "Preview hunk" },
                g = { "Lazygit - TODO" },
            },

            s = {
                name = "Search",
                f = { "Git files" },
                g = { "Git files" },
                r = { "Recent files" },
                t = { "Text" },
                w = { "Word under cursor" },
                k = { "Keymaps" },
            },

            l = {
                name = "LSP",
                a = { "Code action" },
                i = { "Toggle inlay hints" },
                j = { "Next diagnostic" },
                k = { "Previous diagnostic" },
                f = { "Open float diagnostic" },
                r = { "Rename symbol" },
                s = { "List symbols" },
            }

        }, { prefix = "<leader>" })

    end
}
