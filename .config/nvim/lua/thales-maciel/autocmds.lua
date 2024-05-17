local should_enable_inlay_hints = require("thales-maciel.utils").should_enable_inlay_hints
local toggle_inlay_hints = require("thales-maciel.utils").toggle_inlay_hints

-- lsp only keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function (ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("v", "<leader>lf", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("v", "<leader>lj", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("v", "<leader>lk", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("v", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("v", "<leader>lr", function() vim.lsp.buf.rename() end, opts)

        vim.keymap.set("n", "<leader>ls", require('telescope.builtin').lsp_document_symbols, opts)
        vim.keymap.set("n", "<leader>li", toggle_inlay_hints, opts)

        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        local clients= vim.lsp.get_clients({bufnr = ev.buf, method = "textDocument/inlayHint"})
        if #clients > 0 then
            vim.lsp.inlay_hint.enable(ev.buf, should_enable_inlay_hints())
        end
    end
})
