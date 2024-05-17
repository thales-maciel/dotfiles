return {
    {
        "codota/tabnine-nvim",
        build = "./dl_binaries.sh",
        config = function()
            require("tabnine").setup({
                disable_auto_comment=true,
                accept_keymap="<Right>",
                dismiss_keymap="<Left>",
                debounce_ms=700,
                suggestion_color = {gui="#808080", cterm=244},
                exclude_filetypes = {"TelescopePrompt"},
                log_file_path = nil,
            })
        end
    },
}
