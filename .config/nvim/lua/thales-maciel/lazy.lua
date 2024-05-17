-- gets all files from plugins directory
local function get_plugins()
    local plugins = {}
    local plugins_path = vim.fn.stdpath("config") .. "/lua/thales-maciel/plugins"

    for _, file in ipairs(vim.fn.readdir(plugins_path)) do
        if file:match('.+%.lua$') then
            local basename = string.gsub(file, '%.lua$', '')
            local definitions = require('thales-maciel.plugins.' .. basename)
            if type(definitions[1]) == 'table' then
                for _, plugin in ipairs(definitions) do
                    table.insert(plugins, plugin)
                end
            else
                table.insert(plugins, definitions)
            end
        end
    end
    return plugins
end

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = get_plugins()
require("lazy").setup(
    {
        plugins,
        { import = "thales-maciel.plugins.locals" },

    },
    { change_detection = { notify = false } }
)
