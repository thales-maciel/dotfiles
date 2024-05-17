vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function toggle_explorer()
    vim.g.netrw_altfile = 1
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_command("Explore")
    vim.api.nvim_set_var("#", bufnr)
end

vim.keymap.set("n", "<leader>e", toggle_explorer)
vim.keymap.set("n", "ç", ":")

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "P", "p")
vim.keymap.set("v", "p", ":<C-U>let @\"=@O<CR>gvP")

local function join_without_spaces()
    vim.cmd("normal! mm")
    vim.cmd("normal! gJ")
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if char:match("%s") then vim.cmd("normal! dw") end
    vim.cmd("normal! `m")
end

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "gJ", join_without_spaces)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>c", ":bd<CR>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

