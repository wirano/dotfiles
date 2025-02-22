return {
    "skywind3000/asyncrun.vim",
    lazy = true,
    cmd = { "AsyncRun" },

    config = function ()
        vim.g.asyncrun_mode = "term"
    end,
}
