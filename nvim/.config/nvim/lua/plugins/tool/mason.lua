local tools = require("tools")

return {
    "mason-org/mason.nvim",
    cond = tools.is_win(),

    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}
