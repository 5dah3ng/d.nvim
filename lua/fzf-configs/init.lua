local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    fullscreen = true,
    preview = {
      layout = 'vertical',
      vertical = 'up:50%',
      hidden = true,
    },
  },
  files = {
    cmd = "rg --files --hidden --color=never",
    hidden = false,
    previewer = { enabled = false },
    file_icons = false,
    color_icons = false,
    git_icons = false,
    fzf_opts = {
      ["--scheme"] = "path",
      ["--tiebreak"] = "length,begin,index",
    },
  },
  grep = {
    previewer = { enabled = false },
    file_icons = false,
    color_icons = false,
    git_icons = false,
  },
})

local map = vim.keymap.set

-- File finding
map('n', '<leader>ff', fzf.files, { desc = 'Find files' })

-- Live grep
map('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })

-- Word under cursor
map('n', '<leader>fs', fzf.grep_cword, { desc = 'Grep word under cursor' })

-- Visual selection grep
local get_visual = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})
  text = string.gsub(text, "\n", "")
  return #text > 0 and text or ''
end

map('v', '<leader>fs', function()
  fzf.grep({ search = get_visual() })
end, { desc = 'Grep selected text' })

-- C/C++ scoped search
local c_cpp_rg_opts = "-t c -t cpp"

map('n', '<leader>fgc', function()
  fzf.live_grep({ rg_opts = c_cpp_rg_opts })
end, { desc = 'Live grep (C/C++)' })

map('n', '<leader>fsc', function()
  fzf.grep_cword({ rg_opts = c_cpp_rg_opts })
end, { desc = 'Grep word (C/C++)' })

map('v', '<leader>fsc', function()
  fzf.grep({ search = get_visual(), rg_opts = c_cpp_rg_opts })
end, { desc = 'Grep selected (C/C++)' })

-- Resume
map('n', '<leader>fr', fzf.resume, { desc = 'Resume last search' })
