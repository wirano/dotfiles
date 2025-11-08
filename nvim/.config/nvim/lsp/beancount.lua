---@brief
---
--- https://github.com/polarmutex/beancount-language-server#installation
---
--- See https://github.com/polarmutex/beancount-language-server#configuration for configuration options

---@type vim.lsp.Config
return {
	cmd = { "beancount-language-server", "--stdio" },
	filetypes = { "beancount", "bean" },
	root_markers = { ".git" },
	single_file_support = true,
	init_options = {
		journal_file = (function()
			local root = vim.fs.root(0, { ".git", "main.beancount" })
			if root then
				return root .. "/main.beancount"
			end
			return nil
		end)(),
	},
}
