local tools = {}

function tools.is_remote()
    return os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY") or os.getenv("SSH_CONNECTION")
end

function tools.is_tmux()
    return os.getenv("TMUX")
end

function tools.is_vscode()
	return vim.g.vscode == 1
end

function tools.is_win()
	return vim.fn.has("win32") == 1
end

return tools
