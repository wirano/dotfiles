return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
    },

    config = function()
        local navic = require("nvim-navic")

        local curTime = function()
            return os.date("%H:%M:%S", os.time())
        end

        local hostname = function()
            local cache
            return function()
                if cache then
                    return cache
                end
                local data = vim.loop.os_gethostname()
                cache = string.gsub(data, "%.%w+$", "")
                return cache
            end
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", "diagnostics", },
                lualine_c = {
                    { "filename", path = 1 },
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                    },
                },
                lualine_x = {"encoding", "fileformat", "filetype", },
                lualine_y = { "grapple", { curTime } },
                -- lualine_z = { "location" },
                lualine_z = { {
                    "progress",
                    icon = { "󰇽", align = "left" },
                } },
            },
            inactive_sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {},
                lualine_c = { "filetype" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
