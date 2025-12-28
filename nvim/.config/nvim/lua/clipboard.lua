local tools = require("tools")

if tools.is_remote() and not tools.is_tmux() then
    vim.o.clipboard = "unnamedplus"
    vim.g.clipboard = "osc52"
else
    vim.o.clipboard = "unnamedplus"
end
