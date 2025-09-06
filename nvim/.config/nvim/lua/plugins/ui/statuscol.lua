local tools = require("tools")

return {
	"luukvbaal/statuscol.nvim",
	cond = not tools.is_vscode(),

	config = function()
		local builtin = require("statuscol.builtin")
		local ffi = require("statuscol.ffidef")
		local C = ffi.C

		-- only show fold level up to this level
		local fold_level_limit = 5
		local function foldfunc(args)
			local foldinfo = C.fold_info(args.wp, args.lnum)

			if foldinfo.level > fold_level_limit then
				return " "
			end

			return builtin.foldfunc(args)
		end

		require("statuscol").setup({
			relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
			segments = {
				-- Simulate the sign column while not showing the gitsigns
				{
					sign = {
						name = { ".*" },
						text = { ".*" },
					},
					click = "v:lua.ScSa",
				},
				-- Simulate the line number column without the right padding
				{
					text = { builtin.lnumfunc },
					click = "v:lua.ScLa",
				},
				-- Show gitsigns at the position of line numbers' right padding
				{
					sign = {
						namespace = { "gitsigns" },
						colwidth = 1,
						wrap = true,
						foldclosed = true,
					},
					condition = {
						function(args)
							return vim.wo[args.win].number or vim.b[args.buf].gitsigns_status
						end,
					},
					click = "v:lua.ScSa",
				},
				{
					text = {
						function(args)
							args.fold.close = ""
							args.fold.open = ""
							args.fold.sep = " "
							return foldfunc(args)
						end,
						" ",
					},
					condition = { true, builtin.not_empty },
					click = "v:lua.ScFa",
				},
			},
		})
	end,
}
