local tools = require("tools")

return {
    "EdenEast/nightfox.nvim",
    cond = not tools.is_vscode(),

    config = function ()
        vim.cmd('colorscheme nordfox')
    end
}
