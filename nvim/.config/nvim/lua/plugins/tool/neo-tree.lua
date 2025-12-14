return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },

    init = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("load_neo_tree", {}),
            desc = "Loads neo-tree when openning a directory",
            callback = function(args)
                local stats = vim.uv.fs_stat(args.file)

                if not stats or stats.type ~= "directory" then
                    return
                end

                require "neo-tree"

                return true
            end,
        })
    end,

    opts = {
        close_if_last_window = true,
        filesystem = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },
        window = {
            mappings = {
                ["<C-v>"] = "open_vsplit",
            },
        },
        buffers = {
            window = {
                mappings = {
                    ["x"] = "buffer_delete",
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["<space>"] = {
                        function(state)
                            local node = state.tree:get_node()
                            if node.type == "message" then
                                return
                            end
                            local path = node:get_id()
                            local statusCmd =
                                { "git", "status", "--porcelain", path }

                            local function statusCallback(obj)
                                local status = string.sub(obj.stdout, 1, 1)
                                if status == " " then
                                    vim.system(
                                        { "git", "add", path },
                                        nil,
                                        function()
                                            events.fire_event(events.GIT_EVENT)
                                        end
                                    )
                                else
                                    vim.system(
                                        { "git", "reset", path },
                                        nil,
                                        function()
                                            events.fire_event(events.GIT_EVENT)
                                        end
                                    )
                                end
                            end

                            vim.system(
                                statusCmd,
                                { text = true },
                                statusCallback
                            )
                        end,
                        desc = "Toggle staged",
                    },
                },
            },
        },
        source_selector = {
            winbar = true,
            sources = {
                {
                    source = "filesystem",
                    display_name = "  Files ",
                },
                {
                    source = "buffers",
                    display_name = "  Buffers ",
                },
                {
                    source = "git_status",
                    display_name = "  Git ",
                },
                {
                    source = "document_symbols",
                    display_name = "  Symbols",
                },
            },
        },
    },

    config = function(_, opts)
        local events = require "neo-tree.events"
        opts.event_handlers = opts.event_handlers or {}
        require("neo-tree").setup(opts)
        vim.api.nvim_create_augroup("load_neo_tree", {})
    end,

    keys = {
        { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "File Explorer" },
    },
}
