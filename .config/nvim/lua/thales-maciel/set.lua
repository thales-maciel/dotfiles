vim.opt.nu = true
vim.opt.rnu = false

vim.o.cmdheight = 2
vim.o.cul = true

vim.o.clipboard = 'unnamedplus'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.breakindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.o.completeopt = 'menuone,noselect'

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
-- vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle = 3

local highlight_group = vim.api.nvim_create_augroup(
'YankHighlight', { clear = true}
)
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function ()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

