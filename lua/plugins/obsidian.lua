-- lua/plugins/obsidian.lua
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown", -- load only when a Markdown file is opened
  dependencies = { "nvim-lua/plenary.nvim" }, -- required utility library

  -- PERF: obsidian-ls registers a recursive file watcher on the whole vault. Without `inotifywait`
  -- (apt: inotify-tools) Neovim falls back to a slow Lua directory walk -> multi-second freeze on
  -- first .md open. Keep inotify-tools installed on any machine that uses this config.

  opts = {
    legacy_commands = false, -- use only the new `:Obsidian <subcommand>` commands

    -- A workspace is a root folder the plugin treats as a vault.
    -- Features (search, backlinks, new notes) only work inside one.
    workspaces = {
      -- [SPECIFIC] Hard-coded path. Change it, or it breaks on other machines.
      { name = "agentic", path = "~/dev/agentic-workspace/" },
      -- The `cwd` fallback was removed: it made every launch directory a vault,
      -- causing a slow scan the first time a Markdown file was opened.
    },

    -- Skip dependency/build dirs: ~1,770 of the vault's ~1,810 .md files live in web/node_modules.
    file = { ignore_filters = { "node_modules", ".git", "dist", "build", ".next", ".env" } },

    new_notes_location = "current_dir", -- new notes go next to the current file

    -- Title -> filename ("My Idea!" -> "My-Idea"). Default is cryptic IDs.
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
      end
      return tostring(os.time()) -- no title: use a timestamp
    end,

    link = { style = "wiki" }, -- [[note]] instead of [note](note.md)

    -- [SPECIFIC] Folder under the workspace root. Only matters for the template command.
    templates = { folder = "templates" },

    -- picker = { name = "snacks.pick" }, -- auto-detected; uncomment only to force one

    ui = { enable = false }, -- render-markdown.nvim handles visuals instead
  },
}
