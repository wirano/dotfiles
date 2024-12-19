local Server = {}

function Server.checkOK()
    return (vim.fn.executable("clangd") == 1 or vim.fn.executable("ccls") == 1)
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig
    local capabilities = vim.deepcopy(opts.capabilities)

    capabilities.offsetEncoding = "utf-8"

    -- if (vim.fn.executable("clangd") == 1) then
    --     lspconfig.clangd.setup({
    --         capabilities = capabilities,
    --         filetypes = { "c", "cpp", "h" },
    --     })
    -- end

    if (vim.fn.executable("ccls") == 1) then
        lspconfig.ccls.setup({
            init_options = {
                single_file_support = true,
                offset_encoding = capabilities.offsetEncoding,
                index = {
                    threads = 0,
                },
                clang = {
                    excludeArgs = { "-Wall" },
                },
                highlight = {
                    lsRanges = true,
                },
            },
        })
    end
end

return Server
