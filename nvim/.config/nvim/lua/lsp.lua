vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

-- Improve LSPs UI {{{
local icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Keyword = " ",
	Method = "ƒ ",
	Module = "󰏗 ",
	Property = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
	completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

local function on_attach(client, bufnr)
	--
	-- Mappings
	--
	-- Nvim creates the following default LSP mappings:
	--  * K in NORMAL maps to vim.lsp.buf.hover()
	--  * grr in NORMAL maps to vim.lsp.buf.references()
	--  * gri in NORMAL maps to vim.lsp.buf.implementation()
	--  * gO in NORMAL maps to vim.lsp.buf.document_symbol()
	--  * grn in NORMAL maps to vim.lsp.buf.rename()
	--  * gra in NORMAL and VISUAL maps to vim.lsp.buf.code_action()
	--  * <C-s> in INSERT and SELECT maps to vim.lsp.buf.signature_help()
	-- Also, the following default diagnostic mappings are creataed:
	--  * ]d and [d: jump to the next or previous diagnostic
	--  * ]D and [D: jump to the last or first diagnostic
	--  * <C-w>d and <C-w><C-d> map to vim.diagnostic.open_float()
	--

	-- Inlay hints
	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

	-- Enable code lens
	-- if client and client.server_capabilities.codeLensProvider then
	--     vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
	--         buffer = bufnr,
	--         callback = function()
	--             vim.lsp.codelens.refresh({ bufnr = 0 })
	--         end,
	--     })
	-- end

	-- Document highlight
	if client:supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end

	-- Document colors
	-- if client:supports_method("textDocument/documentColor") then
	-- vim.lsp.document_color.enable(true, bufnr)
	-- end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if not client then
			return
		end

		on_attach(client, bufnr)
	end,
})

-- Enable LSP servers
local lsp_configs = {}
for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
	-- Read the first line of the file
	local f = io.open(file, "r")
	local first_line = f and f:read("*l") or ""
	if f then
		f:close()
	end
	-- Only include the file if it doesn't start with "-- disable"
	if not first_line:match("^%-%- disable") then
		local name = vim.fn.fnamemodify(file, ":t:r") -- `:t` gets filename, `:r` removes extension
		table.insert(lsp_configs, name)
	end
end

vim.lsp.enable(lsp_configs)
