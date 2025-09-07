local base_config = {
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },

	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		".ccls",
		"CMakeLists.txt",
		"Makefile",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
}

local ccls_projects = {
	{
		name = "linux",
		directories = {
			"linux",
		},
		remotes = {
			"torvalds/linux",
		},
	},
	{
		name = "qemu",
		directories = {
			"qemu",
		},
		remotes = {
			"qemu/qemu",
		},
	},
}

local function detect_ccls_projects(root_dir)
	local tools = require("tools")

	if tools.is_win() then
		return "clangd", "platform is windows"
	end

	for _, proj in ipairs(ccls_projects) do
		local dir_name = vim.fn.fnamemodify(root_dir, ":t")
		for _, name in ipairs(proj.directories) do
			if string.find(dir_name:lower(), name:lower()) then
				return "ccls", "directory_name"
			end
		end

		for _, remote in ipairs(proj.remotes) do
			local git_dir = root_dir .. "/.git"
			if vim.fn.isdirectory(git_dir) == 1 then
				local remote_output = vim.fn.system("cd " .. root_dir .. " && git remote -v 2>/dev/null")
				if vim.v.shell_error == 0 then
					if string.find(remote_output, remote) then
						return "ccls", "git_remote"
					end
				end
			end
		end
	end

	return "clangd", "fallback"
end

local function switch_source_header(client, bufnr)
	local method_name = "textDocument/switchSourceHeader"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

local clangd_config = {
	cmd = { "clangd" },
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
	},
	init_options = {
		clang = {
			excludeArgs = { "-mabi=lp64" },
		},
	},
	offsetEncoding = { "utf-8", "utf-16" },
	---@param init_result ClangdInitializeResult
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
			switch_source_header(bufnr, client)
		end, { desc = "Switch between source/header" })
	end,
}

local ccls_config = {
	cmd = { "ccls" },
	offset_encoding = "utf-32",
	-- ccls does not support sending a null root directory
	workspace_required = true,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspCclsSwitchSourceHeader", function()
			switch_source_header(client, bufnr)
		end, { desc = "Switch between source/header" })
	end,
	init_options = {
		clang = {
			excludeArgs = { "-mabi=lp64" },
		},
	},
}

local function setup_config()
	local lsp_config
	local root_dir = vim.fs.root(0, base_config.root_markers)
	if not root_dir then
		return
	end
	local lsp_name, reason = detect_ccls_projects(root_dir)

	if lsp_name == "clangd" then
		lsp_config = vim.tbl_extend("force", base_config, clangd_config)
	else
		lsp_config = vim.tbl_extend("force", base_config, ccls_config)
	end

	require("notify")(string.format("LSP: %s (%s)", lsp_name, reason), "info")

	return lsp_config
end

return setup_config()
