require("neo-tree").setup({
  filesystem = {
    use_libuv_file_watcher = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = { ".git", "node_modules", "__pycache__" },
    },
  },
  async_directory_scan = "always",

  window = {
    mappings = {
      ["F"] = function(state)
        require("neo-tree-configs/neo-tree-diff").diff(state)
      end,
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>nn', '<cmd>Neotree toggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>Neotree reveal<cr>', { noremap = true, silent = true })

