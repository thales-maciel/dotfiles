return {
    "goolord/alpha-nvim",
    -- lazy = true,
    opts = function()
        require("alpha.term")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
            dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
            dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "AlphaShortcut"
        dashboard.section.buttons.opts.hl = "AlphaButtons"

        local width = 46
        local height = 25 -- two pixels per vertical space
        dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .."/scripts/thisisfine.sh"
        dashboard.section.terminal.width = width
        dashboard.section.terminal.height = height
        dashboard.section.terminal.opts.redraw = true

        dashboard.section.header.val = "Build something cool"

        dashboard.config.layout = {
            { type = "padding", val = 1 },
            dashboard.section.terminal,
            { type = "padding", val = 5 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        vim.keymap.set("n", "<leader>:", "<cmd>Alpha<CR>")
        vim.keymap.set("n", "<leader>ç", "<cmd>Alpha<CR>")

        return dashboard.config
    end,
}
