--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/init.lua
-- Description: Plugin specifications for lazy.nvim

-- ─── Color / Utility Plugins ─────────────────────────────────────────────
local colorizer = {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = { enable_hex = true, enable_short_hex = true, enable_rgb = true, enable_hsl = true },
}

local which_key = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        icons = {
            mappings = true,
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
    end,
}

-- ─── Core Plugins ────────────────────────────────────────────────────────
local plenary = { "nvim-lua/plenary.nvim" }

local mini_misc = {
    "nvim-mini/mini.misc",
    event = "UIEnter",
    config = function()
        require("mini.misc").setup()
        require("mini.misc").setup_termbg_sync()
    end,
}

local mini_files = {
    "nvim-mini/mini.files",
    keys = {
        {
            "<leader>fm",
            function()
                require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
            end,
            desc = "Open mini.files (current file dir)",
        },
        {
            "<leader>fM",
            function()
                require("mini.files").open(vim.uv.cwd(), true)
            end,
            desc = "Open mini.files (cwd)",
        },
    },
    config = function()
        require("mini.files").setup(require("plugins.configs.mini-files"))
        -- Disable treesitter for mini.files buffers to prevent errors
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                pcall(vim.treesitter.stop, args.data.buf_id)
            end,
        })
    end,
}

-- ─── Formatter ───────────────────────────────────────────────────────────
local conform = {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = { lua = { "stylua" } },
        format_on_save = { timeout_ms = 1000, lsp_fallback = true },
    },
}

-- ─── Git ─────────────────────────────────────────────────────────────────
local gitsigns = {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        return require("plugins.configs.gitsigns")
    end,
}

-- ─── Treesitter ──────────────────────────────────────────────────────────
local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
    build = ":TSUpdate",
    branch = "main",
    config = function()
        require("plugins.configs.treesitter")
    end,
}

-- ─── Mini.pick ───────────────────────────────────────────────────────────
local mini_pick = {
    "nvim-mini/mini.pick",
    dependencies = { plenary, "nvim-mini/mini.extra" },
    cmd = "Pick",
    keys = {
        {
            "<leader>sh",
            function()
                require("mini.pick").builtin.help({})
            end,
            desc = "[S]earch [H]elp",
        },
        {
            "<leader>sk",
            function()
                require("mini.extra").pickers.keymaps({})
            end,
            desc = "[S]earch [K]eymaps",
        },
        {
            "<leader>sf",
            function()
                require("mini.pick").builtin.files({})
            end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>sg",
            function()
                require("mini.pick").builtin.grep_live({})
            end,
            desc = "[S]earch by [G]rep",
        },
        {
            "<leader>sd",
            function()
                require("mini.extra").pickers.diagnostic({})
            end,
            desc = "[S]earch [D]iagnostics",
        },
        {
            "<leader>sc",
            function()
                require("mini.extra").pickers.git_commits({})
            end,
            desc = "[S]earch git commits",
        },
        {
            "<leader>s.",
            function()
                require("mini.extra").pickers.oldfiles({})
            end,
            desc = "[S]earch Recent Files",
        },
        {
            "<leader><leader>",
            function()
                require("mini.pick").builtin.buffers({})
            end,
            desc = "[ ] Find existing buffers",
        },
        {
            "<leader>sr",
            function()
                require("mini.pick").builtin.resume({})
            end,
            desc = "[S]earch [R]esume",
        },
    },
    opts = {
        source = {
            show_icons = true,
        },
    },
}

-- ─── Statusline ──────────────────────────────────────────────────────────
local lualine = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return require("plugins.configs.lualine")
    end,
}

-- ─── Colorscheme ─────────────────────────────────────────────────────────
local rosepine = {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000, -- load first
    opts = { dark_variant = "main" },
    config = function(_, opts)
        require("rose-pine").setup(opts)
        vim.cmd.colorscheme("rose-pine")
    end,
}

-- ─── Mason ───────────────────────────────────────────────────────────────
local mason = {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
        return require("plugins.configs.mason")
    end,
}

local mason_lspconfig = {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { mason },
}

-- ─── Linters / Formatters (null-ls successor) ────────────────────────────
local none_ls = {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    opts = function()
        return require("plugins.configs.null-ls")
    end,
}

-- ─── LSP ─────────────────────────────────────────────────────────────────
local lspconfig = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { mason_lspconfig },
    config = function()
        require("plugins.configs.lspconfig")
    end,
}

-- ─── Completion ──────────────────────────────────────────────────────────
local cmp = {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "LspAttach" },
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").config.set_config(opts)
                require("plugins.configs.luasnip")
            end,
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {
                check_ts = true,
                ts_config = { lua = { "string" }, javascript = { "template_string" }, java = false },
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.]",
                fast_wrap = {},
                disable_filetype = { "MiniPick", "vim", "minifiles" },
            },
        },
    },
    opts = function()
        return require("plugins.configs.cmp")
    end,
    opts_extend = { "sources.default" },
}

-- ─── Build spec ──────────────────────────────────────────────────────────
local exist, custom = pcall(require, "custom")
local custom_plugins = exist and type(custom) == "table" and custom.plugins or {}

local specs = {
    rosepine,
    colorizer,
    which_key,
    plenary,
    mini_misc,
    mini_files,
    conform,
    gitsigns,
    treesitter,
    mini_pick,
    lualine,
    mason,
    mason_lspconfig,
    none_ls,
    lspconfig,
    cmp,
    -- Custom plugins (if any)
    unpack(custom_plugins),
}

require("lazy").setup({
    spec = specs,

    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
    defaults = { lazy = false, version = nil },

    ui = {
        icons = {
            ft = "",
            lazy = "󰂠",
            loaded = "",
            not_loaded = "",
        },
    },

    install = {
        missing = true,
        colorscheme = { "rose-pine", "habamax" },
    },

    checker = {
        enabled = true,
        notify = false,
        frequency = 86400,
    },

    change_detection = {
        enabled = true,
        notify = false,
    },

    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            reset = true,
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tutor",
                "zipPlugin",
            },
        },
    },

    state = vim.fn.stdpath("state") .. "/lazy/state.json",
})
