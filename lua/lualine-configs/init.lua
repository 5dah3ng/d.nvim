require('lualine').setup{
    options = {
        theme = require('lualine.themes.onedark'),
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', extra_sources = { 'treesitter' } }, 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
}

