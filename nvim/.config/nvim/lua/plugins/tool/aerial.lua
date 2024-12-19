return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    float = {
      border = "rounded",
    },
  },
  keys = {
    { "<leader>a", "<Cmd>AerialToggle<CR>", desc = "Outline" },
  },
}
