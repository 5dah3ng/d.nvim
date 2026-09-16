
-- Set runtime path to include your .vim directory and the after directory
-- vim.o.runtimepath = vim.o.runtimepath .. ',~/.vim,~/.vim/after'
--
-- -- Set packpath to be the same as runtimepath
-- vim.o.packpath = vim.o.runtimepath
--
-- Disable unused builtin plugins (must be set before they load)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1

vim.g.mapleader = ','

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", {desc = "save"})

vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "left window"})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "right window"})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "up window"})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "down window"})

require('lazy-configs')

-- Terminal mode escape mapping
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

--h>", "<C-w>h", {desc = "left window"})
-- 17 vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "right window"})
--  18 vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp,hpp,h,c",
  command = "setlocal commentstring=//\\ %s"
})
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
--
-- vim.wo.relativenumber = true

vim.cmd('colorscheme onedark')

vim.cmd('set number')

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
