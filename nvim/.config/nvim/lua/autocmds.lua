-- " When editing a file, always jump to the last known cursor position.
-- " Don't do it when the position is invalid or when inside an event handler
-- " (happens when dropping a file on gvim).
-- " Also don't do it when the mark is in the first line, that is the default
-- " position when opening a file.
-- autocmd BufReadPost *
--   \ if line("'\"") > 1 && line("'\"") <= line("$") |
--   \   exe "normal! g`\"" |
--   \ endif
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore last cursor position",
  callback = function()
    local pos = vim.api.nvim_buf_get_mark(0, '"')

    if pos[1] > 1 and pos[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, pos)
    end
  end,
})
