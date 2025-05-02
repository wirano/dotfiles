return {
	"saghen/blink.cmp",
	build = "cargo build --release",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_next()
					elseif cmp.snippet_active() then
						return cmp.snippet_forward()
					else
						return false
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					elseif cmp.snippet_active() then
						return cmp.snippet_backward()
					else
						return false
					end
				end,
				"fallback",
			},
		},

		cmdline = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},

			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				menu = { auto_show = true },
			},
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		signature = { enabled = true },

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon" },
					},
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
