-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins using lazy.nvim
require('lazy').setup({
    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { "c", "cpp", "go", "python", "lua", "vim", "vimdoc", "query" },
            auto_install = true,
            highlight = { enable = true },
        },
        -- config = function(_, opts)
        --   require('nvim-treesitter.configs').setup(opts)
        -- end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>nn", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
            { "<leader>nf", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neo-tree" },
        },
        config = function()
            require('neo-tree-configs')
        end
    },

    -- Neogen for annotation generation
    {
        'danymat/neogen',
        config = function()
            require('neogen-configs')
        end
    },

    -- Lazygit
    {
        'kdheepak/lazygit.nvim',
        cmd = "LazyGit",
        keys = {
            { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
        },
    },


    -- toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            require('term-configs')
        end
    },

    -- nvim-dap for debugging
    {
        'mfussenegger/nvim-dap',
        config = function()
            require('dap-configs')
        end
    },
    'mfussenegger/nvim-dap-python',

    -- plenary (dependency of neo-tree)
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },

    -- Barbar for tabline
    {
        'romgrk/barbar.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('barbar-configs')
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine-configs')
        end
    },

    -- Indent blankline
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl-configs')
        end
    },

    -- Themes
    'navarasu/onedark.nvim',

    {
        url = "https://codeberg.org/andyg/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
            require('leap-configs')
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    {
        'tpope/vim-fugitive'
    },

    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig-configs')
        end
    },

    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require('mason-configs')
        end
    },

    {
    	"chrisgrieser/nvim-origami",
    	event = "VeryLazy",
    	opts = {}, -- needed even when using default config

    	-- recommended: disable vim's auto-folding
    	init = function()
    		vim.opt.foldlevel = 99
    		vim.opt.foldlevelstart = 99
    	end,
    },

    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
                ['<CR>'] = { 'accept', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "lua" }
        },
        opts_extend = { "sources.default" },
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('fzf-configs')
        end,
    },
    {
        'echasnovski/mini.pick',
        version = '*',
        config = function()
            require('mini-pick-configs')
        end,
    },
    {
        'echasnovski/mini.icons',
        version = '*',
        lazy = true,
    },
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require 'window-picker'.setup()
        end,
    },

    -- {
    --     "nvchad/ui",
    --     config = function()
    --         require "nvchad"
    --     end
    -- },
    --
    -- {
    --     "nvchad/base46",
    --     lazy = true,
    --     build = function()
    --         require("base46").load_all_highlights()
    --     end,
    -- },
    -- "nvchad/volt"
})
