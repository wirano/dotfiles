local Server = {}

function Server.checkOK()
    return vim.fn.executable("tinymist") == 1
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig
    lspconfig.tinymist.setup(
        {}
    )
end

return Server
