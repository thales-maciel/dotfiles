local M = {}

local orig_diag_virt_handler = vim.diagnostic.handlers.virtual_text
local ns = vim.api.nvim_create_namespace("thales_diagnostics")

local filter_diagnostics = function (diagnostics, level)
    local filtered_diag = {}
    for _, d in ipairs(diagnostics) do
        if d.severity <= level then
            table.insert(filtered_diag, d)
        end
    end
    return filtered_diag
end

local set_level = function (level)
    -- hide all diagnostics
    vim.diagnostic.hide(nil, 0)

    -- vim.diagnostic.reset()
    vim.diagnostic.handlers.virtual_text = {
        show = function (_, bufnr, _, opts)
            -- get all diagnostics for local buffer
            local diagnostics = vim.diagnostic.get(bufnr)
            -- filter diagnostics by severity
            local filtered = filter_diagnostics(diagnostics, level)
            orig_diag_virt_handler.show(ns, bufnr, filtered, opts)
        end,
        hide = function (_, bufnr)
            orig_diag_virt_handler.hide(ns, bufnr)
        end
    }

    local bufnr = vim.api.nvim_get_current_buf()
    local diags = vim.diagnostic.get(bufnr)

    if #diags > 0 then
        local filtered = filter_diagnostics(diags, level)
        vim.diagnostic.show(ns, bufnr, filtered)
    end
end

M.select_level = function ()
    vim.ui.select(
        {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },
        {
            prompt = "Choose severity",
            format_item = function (item)
                if item == 1 then
                    return "Error"
                elseif item == 2 then
                    return "Warn"
                elseif item == 3 then
                    return "Info"
                elseif item == 4 then
                    return "Hint"
                end
            end
        },
        function(choice)
            set_level(choice)
        end)
end

return M
