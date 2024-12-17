return {
    'stevearc/conform.nvim',
    event = "VeryLazy",
    config = function()
        local conform = require("conform")

        local opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                json = { "jq" },
                yaml = { "yamlfmt" },
                markdown = { "autocorrect" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
            },
        }

        conform.formatters.jq = {
            prepend_args = { "--indent", "4" },
        }

        conform.setup(opts)
    end,
}
