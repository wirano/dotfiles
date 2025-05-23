return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"SmiteshP/nvim-navic",
	},

	config = function()
		local curTime = function()
			return os.date("%H:%M:%S", os.time())
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", path = 1 },
					{
						"aerial",
						-- The separator to be used to separate symbols in status line.
						sep = " > ",

						-- The number of symbols to render top-down. In order to render only 'N' last
						-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
						-- be used in order to render only current symbol.
						depth = nil,

						-- When 'dense' mode is on, icons are not rendered near their symbols. Only
						-- a single icon that represents the kind of current symbol is rendered at
						-- the beginning of status line.
						dense = false,

						-- The separator to be used to separate symbols in dense mode.
						dense_sep = ".",

						-- Color the symbol icons.
						colored = true,
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "grapple", { curTime } },
				-- lualine_z = { "location" },
				lualine_z = {
					{
						"progress",
						icon = { "󰇽", align = "left" },
					},
				},
			},
			inactive_sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {},
				lualine_c = { "filetype" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "aerial", "neo-tree" },
		})
	end,
}
