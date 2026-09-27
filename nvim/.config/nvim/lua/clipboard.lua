local tools = require("tools")

if tools.is_remote() and not tools.is_tmux() then
    vim.g.clipboard = "osc52"
end

vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({"n", "v"}, "<leader>Y", '"+Y')
vim.keymap.set({"n", "v"}, "<leader>p", '"+p')
vim.keymap.set({"n", "v"}, "<leader>P", '"+P')
