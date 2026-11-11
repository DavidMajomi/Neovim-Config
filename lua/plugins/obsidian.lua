-- lua/plugins/obsidian.lua
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown", -- load only when a Markdown file is opened
  dependencies = { "nvim-lua/plenary.nvim" }, -- required utility library

  opts = {
    legacy_commands = false, -- use only the new `:Obsidian <subcommand>` commands

    -- A workspace is a root folder the plugin treats as a vault.
    -- Features (search, backlinks, new notes) only work inside one.
    workspaces = {
      -- [SPECIFIC] Hard-coded path. Change it, or it breaks on other machines.
      { name = "agentic", path = "~/dev/agentic-workspace/" },

      -- [GENERAL] Fallback: uses the directory Neovim was launched from.
      -- Set once at startup; ignores later :cd. Listed second so the specific one wins.
      {
        name = "cwd",
        path = function()
          return vim.fn.getcwd()
        end,
        overrides = { frontmatter = { enabled = false } }, -- don't add YAML headers in code repos
      },
    },

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
