vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.asl", "*.dsl" },
	command = "set filetype=asl",
})
