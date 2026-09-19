local pick = require("mini.pick")
local map = vim.keymap.set

pick.setup({
  window = {
    config = function()
      local w = math.floor(vim.o.columns * 0.96)
      local h = math.floor(vim.o.lines * 0.94)
      return {
        border = "rounded",
        relative = "editor",
        anchor = "NW",
        width = w,
        height = h,
        row = math.floor((vim.o.lines - h) / 2),
        col = math.floor((vim.o.columns - w) / 2),
      }
    end,
  },
  delay = {
    async = 5,
    busy = 100,
  },
})

-- Buffers (instant, few items)
map("n", "<leader>fb", pick.builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>o", pick.builtin.buffers, { desc = "Buffers" })

-- Help tags
map("n", "<leader>fh", pick.builtin.help, { desc = "Help tags" })

