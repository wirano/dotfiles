---@type LazyPluginSpec
return {
  "dlyongemallo/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  opts = function()
    return {
      enhanced_diff_hl = true,
    }
  end,
}
