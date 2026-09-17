return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
        },
      },
    },
    keys = {
      {
        "<leader>o",
        function()
          local explorer = Snacks.picker.get({ source = "explorer" })[1]

          local function focus_editor(picker)
            local picker_wins = {}
            for _, win in pairs(picker.layout.wins or {}) do
              if win.win then
                picker_wins[win.win] = true
              end
            end
            local root = picker.layout.root
            if root and root.win then
              picker_wins[root.win] = true
            end
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.api.nvim_win_is_valid(win) and not picker_wins[win] then
                vim.api.nvim_set_current_win(win)
                return
              end
            end
          end

          if explorer and explorer:is_focused() then
            focus_editor(explorer)
          else
            explorer = Snacks.explorer.reveal()
            if explorer then
              explorer:focus()
            end
          end
        end,
        desc = "Toggle Explorer Focus",
      },
    },
  },
}
