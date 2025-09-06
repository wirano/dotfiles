local tools = {}

function tools.is_vscode()
	return vim.g.vscode == 1
end

function tools.is_win()
	return vim.fn.has("win32") == 1
end

return tools
