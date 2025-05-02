vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

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
	if vim.g.inlay_hint_enabled then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

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
	if client:supports_method("textDocument/documentColor") then
		vim.lsp.document_color.enable(true, bufnr)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		on_attach(client, bufnr)
	end,
})

-- Enable LSP servers
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
	local name = vim.fn.fnamemodify(v, ":t:r")
	lsp_configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(lsp_configs))
