return {
    "sindrets/diffview.nvim",
    config = function()
        local diffview = require("diffview")

        diffview.setup({
            enhanced_diff_hl = true,
        })
    end,
}
