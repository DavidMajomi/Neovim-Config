-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- lua/config/autocmds.lua or options.lua

-- Overide default root detection to use only git and cwd rather than other files like Dockerfiles.
vim.g.root_spec = { { ".git" }, "cwd" }
