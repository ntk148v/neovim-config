--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/init.lua
-- Description: init plugins config
return {
    "nvim-lua/plenary.nvim",
    -- File explore
    -- nvim-tree.lua - A file explorer tree for neovim written in lua
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            opt = true
        },
        opts = function()
            return require("configs.tree")
        end,
    },
    -- Formatter
    -- Lightweight yet powerful formatter plugin for Neovim
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = { lua = { "stylua" } },
        },
    },
    -- Git integration for buffers
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require("configs.gitsigns")
        end,
    },
    -- Treesitter interface
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn"t work on Windows
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require("configs.treesitter")
        end,
    },
    -- Telescope
    -- Find, Filter, Preview, Pick. All lua, all the time.
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            }
        },
        cmd = "Telescope",
        config = function(_)
            require("telescope").setup()
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("fzf")
            require("configs.telescope")
        end
    },
    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    {
        "nvim-lualine/lualine.nvim",
        opts = function()
            return require("configs.lualine")
        end
    },
    -- colorscheme
    {
        -- Rose-pine - Soho vibes for Neovim
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            dark_variant = "main"
        }
    },
    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            return require("configs.autopairs")
        end
    },
    -- LSP stuffs
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        config = function()
            return require("configs.mason")
        end
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        config = function()
            return require("configs.lspconfig")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require("configs.luasnip")
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    check_ts = true,
                    ts_config = {
                        lua = { "string" }, -- it will not add a pair on that treesitter node
                        javascript = { "template_string" },
                        java = false        -- Don't check treesitter on java
                    },

                    -- Don't add pairs if it already has a close pair in the same line
                    enable_check_bracket_line = false,

                    -- Don't add pairs if the next char is alphanumeric
                    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" }
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require("configs.cmp")
        end,
    },
    -- Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function(_)
            require("colorizer").setup()

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end
    }
}
