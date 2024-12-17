return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- install language parser
            -- :TSInstallInfo to show supported lang
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "go",
                "html",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "proto",
                "regex",
                "rust",
                "vim",
                "vimdoc",
                "yaml",
            },
            -- enable highlight
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "grc",
                    node_decremental = "<M-CR>",
                },
            },
        })
    end,
}
