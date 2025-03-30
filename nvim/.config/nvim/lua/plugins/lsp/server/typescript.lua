local Server = {}

function Server.checkOK()
    return vim.fn.executable("typescript-language-server") == 1
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig
    lspconfig.ts_ls.setup({
        init_options = {
            plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/usr/lib/node_modules/@vue/typescript-plugin",
                languages = {"vue"},
            },
            },
        },
        filetypes = {
            "javascript",
            "typescript",
            "vue",
        },
        settings = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    })
end

return Server
