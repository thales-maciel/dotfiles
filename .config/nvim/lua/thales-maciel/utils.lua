local M = {}

local INLAY_HINT_ENABLED = false;

function M.should_enable_inlay_hints()
    return INLAY_HINT_ENABLED
end

local function update_inlay_hints()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local clients= vim.lsp.get_clients({bufnr = buf, method = "textDocument/inlayHint"})
        if #clients > 0 then
            vim.lsp.inlay_hint.enable(buf, INLAY_HINT_ENABLED)
        end
    end
end

function M.toggle_inlay_hints()
    INLAY_HINT_ENABLED = not INLAY_HINT_ENABLED
    update_inlay_hints()
end

function M.get_bin_path(bin)
    return vim.fn.stdpath("data") .. "/mason/bin/" .. bin
end

return M

