return {
	"stevearc/conform.nvim",
	event = "VeryLazy",

	opts = {
		default_format_opts = { timeout_ms = 500, lsp_format = "fallback" },
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },
			json = { "jq" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			rust = { "rustfmt", lsp_format = "fallback" },
			yaml = { "yamlfmt" },
		},

		format_on_save = {
			timeout_ms = 100,
			lsp_fallback = true,
		},
	},
}
