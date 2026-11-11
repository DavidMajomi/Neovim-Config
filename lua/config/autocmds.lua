-- Auto update buffer on external code changes
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime", -- reload the buffer if the file changed on disk
})

-- [GENERAL] Markdown-only editing preferences, any folder.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true -- wrap long lines instead of scrolling sideways
    vim.opt_local.linebreak = true -- wrap at word boundaries
    vim.opt_local.spell = false -- LazyVim enables spellcheck; red underlines add noise
  end,
})
