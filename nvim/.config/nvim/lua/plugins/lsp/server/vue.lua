
local Server = {}

function Server.checkOK()
    return vim.fn.executable("vue-language-server") == 1
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig
    lspconfig.volar.setup({
    })
end

return Server
