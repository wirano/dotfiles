return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	opts = {
		-- Provide the path to binaries for dependencies.
		-- Setting this will skip the download of the binary by the plugin.
		-- Warning: Be aware that your version might be older than the one
		-- required.
		dependencies_bin = {
			["tinymist"] = "tinymist",
			["websocat"] = "websocat",
		},
	}, -- lazy.nvim will implicitly calls `setup {}`
}
