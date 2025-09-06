local tools = require("tools")

return {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not tools.is_vscode(),
}
