return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        -- Change diagnostic symbols in the sign column (gutter)
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Override floating window settings
        local lspUtilOpenFloatingPreview = vim.lsp.util.open_floating_preview
        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            local bufnr, winnr = lspUtilOpenFloatingPreview(contents, syntax, opts, ...)
            if bufnr then
                vim.api.nvim_win_set_var(winnr, "winblend", 10)
            end
            return bufnr, winnr
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                if client.supports_method("textDocument/inlayHints") then
                    vim.lsp.inlay_hint.enable()
                end

                local buffer = args.buf

                vim.api.nvim_buf_set_keymap(buffer, "n", "<space>r", '', { callback = vim.lsp.buf.rename, desc = "Rename" })
            end,
        })

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local lspOpts = {
            capabilities = capabilities,
            lspconfig = lspconfig,
        }

        local servers = {
            "c",
            "lua",
            "markdown",
            "python",
            "rust",
        }

        for _, server in ipairs(servers) do
            local prerequire = function(module)
                local ok, result = pcall(require, module)
                if ok then
                    return result
                else
                    return nil
                end
            end
            local serverModule = prerequire("plugins.lsp.server." .. server)
            if serverModule and serverModule.checkOK() then
                serverModule.setup(lspOpts)
            else
            end
        end
    end,
}
