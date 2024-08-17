_G.thaloco_resize_mode = false

function toggle_resize_mode()
    _G.thaloco_resize_mode = not _G.thaloco_resize_mode
    if _G.thaloco_resize_mode then
        print("resize mode enabled")
    else
        print("resize mode disabled")
    end
end

vim.keymap.set("n", "<leader>r", toggle_resize_mode)
