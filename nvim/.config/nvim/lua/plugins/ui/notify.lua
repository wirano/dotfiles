local tools = require("tools")

return {
    "rcarriga/nvim-notify",
    cond = not tools.is_vscode(),
    event = "VeryLazy",
    config = function()
        local nvim_notify = require("notify")
        nvim_notify.setup {
        -- Animation style
        stages = "fade_in_slide_out",
        -- Default timeout for notifications
        timeout = 1500,
        background_colour = "#2E3440",
        }

        vim.notify = nvim_notify
    end,
}
