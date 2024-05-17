return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap",

        "mxsdev/nvim-dap-vscode-js",
        "nvim-telescope/telescope-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local get_bin_path = require("thales-maciel.utils").get_bin_path
        local adapters = {
            setup = function (dap)
                dap.adapters.node2 = {
                    type = "executable",
                    command = "node",
                    args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" }
                }
                dap.adapters.delve = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = get_bin_path("dlv"),
                        args = { "dap", "-l", "127.0.0.1:${port}" }
                    }
                }
                dap.adapters.codelldb = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = get_bin_path("codelldb"),
                        args = { "--port", "${port}" }
                    }
                }
                dap.adapters.cppdbg = {
                    id = "cppdbg",
                    type = "executable",
                    command = get_bin_path("OpenDebugAD7"),
                }
            end
        }
        local configurations = {
            setup = function (dap)
                dap.configurations = {
                    javascript = {
                        {
                            type = 'node2',
                            name = 'Launch',
                            request = 'launch',
                            program = '${file}',
                            cwd = vim.fn.getcwd(),
                            sourceMaps = true,
                            protocol = 'inspector',
                            console = 'integratedTerminal',
                        },
                        {
                            type = 'node2',
                            name = 'Attach',
                            request = 'attach',
                            program = '${file}',
                            cwd = vim.fn.getcwd(),
                            sourceMaps = true,
                            protocol = 'inspector',
                            console = 'integratedTerminal',
                        },
                        {
                            name = "Vitest Debug",
                            type = "pwa-node",
                            request = "launch",
                            cwd = vim.fn.getcwd(),
                            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                            args = { "--threads", "false", "run", "${file}" },
                            autoAttachChildProcesses = true,
                            smartStep = true,
                            console = "integratedTerminal",
                            skipFiles = { "<node_internals>/**", "node_modules/**" },
                        },
                    },
                    typescript = {
                        {
                            type = 'node2',
                            name = 'Launch',
                            request = 'launch',
                            program = '${file}',
                            cwd = vim.fn.getcwd(),
                            sourceMaps = true,
                            protocol = 'inspector',
                            console = 'integratedTerminal',
                        },
                        {
                            type = 'node2',
                            name = 'Attach',
                            request = 'attach',
                            program = '${file}',
                            cwd = vim.fn.getcwd(),
                            sourceMaps = true,
                            protocol = 'inspector',
                            console = 'integratedTerminal',
                        },
                        {
                            name = "Vitest Debug",
                            type = "pwa-node",
                            request = "launch",
                            cwd = vim.fn.getcwd(),
                            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                            args = { "--threads", "false", "run", "${file}" },
                            autoAttachChildProcesses = true,
                            smartStep = true,
                            console = "integratedTerminal",
                            skipFiles = { "<node_internals>/**", "node_modules/**" },
                        },
                    },
                    javascriptreact = {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Chrome",
                        webRoot = "${workspaceFolder}",
                    },
                    rust = {
                        {
                            name = 'Rust Debug',
                            type = "cppdbg",
                            request = "launch",
                            program = function ()
                                vim.fn.jobstart("cargo build")
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/target/debug/', 'file')
                            end,
                            cwd = "${workspaceFolder}",
                            stopOnEntry = true,
                            miDebuggerPath = "/usr/bin/gdb"
                        },
                        {
                            name = 'Rust dbg with codelldb',
                            type = "codelldb",
                            request = "launch",
                            program = function ()
                                vim.fn.jobstart("cargo build")
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd().. '/target/debug/', 'file')
                            end
                        }
                    },
                    go = {
                        {
                            type = "delve",
                            name = "Debug",
                            request = "launch",
                            program = "${file}",
                        },
                        {
                            type = "delve",
                            name = "Debug test",
                            request = "launch",
                            mode = "test",
                            program = "${file}",
                        },
                        {
                            type = "delve",
                            name = "Debug Test (go.mod)",
                            request = "launch",
                            mode = "test",
                            program = "./${relativeFileDirname}",
                        },
                    }
                }
            end
        }
        local mason = require("mason")
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dap_vt = require("nvim-dap-virtual-text")

        dap_vt.setup({
            enabled = true,
            enable_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })

        vim.g.dap_virtual_text = true
        dap.set_log_level("TRACE")

        mason.setup()
        mason_dap.setup({
            ensure_installed = { "codelldb", "cppdbg", "delve", "node2", "js" },
            automatic_installation = true,
        })

        dap.listeners.after.event_initialized["dapui_config"] = function () ui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function () ui.close() end
        dap.listeners.after.event_exited["dapui_config"] = function () ui.close() end

        adapters.setup(dap)
        configurations.setup(dap)

        local function dap_start_debugging()
            dap.continue({})
            vim.cmd("tabedit %")
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", false, true, true), "n", false)
            ui.toggle({})
        end

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dT", function ()
            dap.set_breakpoint(vim.fn.input "Condition > ")
        end)

        vim.keymap.set("n", "<leader>ds", dap_start_debugging)
        vim.keymap.set("n", "<leader>dx", dap.terminate)
        vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
        vim.keymap.set("n", "<leader>dL", dap.continue)
        vim.keymap.set("n", "<leader>dh", dap.step_back)
        vim.keymap.set("n", "<leader>dk", dap.step_out)
        vim.keymap.set("n", "<leader>dl", dap.step_over)
        vim.keymap.set("n", "<leader>dj", dap.step_into)
        vim.keymap.set("n", "<leader>dr", dap.repl.toggle)

        ui.setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.30 },
                        { id = "stacks", size = 0.10 },
                        { id = "watches", size = 0.30 }
                    },
                    position = "right",
                    size = 50
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 }
                    },
                    position = "bottom",
                    size = 10
                }
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        })

        vim.keymap.set("n", "<leader>dU", ui.toggle)
        vim.keymap.set("n", "<leader>de", ui.eval)
        vim.keymap.set("n", "<leader>dE", function ()
            ui.eval(vim.fn.input "Expression > ")
        end)

    end
}
