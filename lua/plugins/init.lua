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
        { "<leader>fm", desc = "Open mini.files (current file dir)" },
        { "<leader>fM", desc = "Open mini.files (cwd)" },
    },
    opts = require("plugins.configs.mini-files"),
    config = function(_, opts)
        require("mini.files").setup(opts)

        local show_dotfiles = true
        local filter_show = function(_)
            return true
        end
        local filter_hide = function(fs_entry)
            return not vim.startswith(fs_entry.name, ".")
        end

        local toggle_dotfiles = function()
            show_dotfiles = not show_dotfiles
            local new_filter = show_dotfiles and filter_show or filter_hide
            require("mini.files").refresh({ content = { filter = new_filter } })
        end

        local map_split = function(buf_id, lhs, direction, close_on_file)
            local rhs = function()
                local cur_win = require("mini.files").get_explorer_state().target_window
                if cur_win then
                    vim.api.nvim_win_call(cur_win, function()
                        vim.cmd("belowright " .. direction .. " split")
                        local new_win = vim.api.nvim_get_current_win()
                        require("mini.files").set_target_window(new_win)
                        require("mini.files").go_in({ close_on_file = close_on_file })
                    end)
                end
            end
            local desc = "Open in " .. direction .. " split"
            if close_on_file then
                desc = desc .. " and close"
            end
            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
                map_split(buf_id, "<C-w>s", "horizontal", false)
                map_split(buf_id, "<C-w>v", "vertical", false)
                map_split(buf_id, "<C-w>S", "horizontal", true)
                map_split(buf_id, "<C-w>V", "vertical", true)
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
    opts = function()
        return require("plugins.configs.treesitter")
    end,
}

-- ─── Mini.pick ───────────────────────────────────────────────────────────
local mini_pick = {
    "nvim-mini/mini.pick",
    dependencies = { plenary, "nvim-mini/mini.extra" },
    cmd = "Pick",
    keys = {
        { "<leader>sh", function() require("mini.pick").builtin.help({}) end, desc = "[S]earch [H]elp" },
        { "<leader>sk", function() require("mini.extra").pickers.keymaps({}) end, desc = "[S]earch [K]eymaps" },
        { "<leader>sf", function() require("mini.pick").builtin.files({}) end, desc = "[S]earch [F]iles" },
        { "<leader>sg", function() require("mini.pick").builtin.grep_live({}) end, desc = "[S]earch by [G]rep" },
        { "<leader>sd", function() require("mini.extra").pickers.diagnostic({}) end, desc = "[S]earch [D]iagnostics" },
        { "<leader>sc", function() require("mini.extra").pickers.git_commits({}) end, desc = "[S]earch git commits" },
        { "<leader>s.", function() require("mini.extra").pickers.oldfiles({}) end, desc = "[S]earch Recent Files" },
        { "<leader><leader>", function() require("mini.pick").builtin.buffers({}) end, desc = "[ ] Find existing buffers" },
        { "<leader>sr", function() require("mini.pick").builtin.resume({}) end, desc = "[S]earch [R]esume" },
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
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Snippet engine
        {
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            event = "InsertEnter",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").config.set_config(opts)
                require("plugins.configs.luasnip")
            end,
        },

        -- Autopairs
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {
                check_ts = true,
                ts_config = { lua = { "string" }, javascript = { "template_string" }, java = false },
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.]",
                fast_wrap = {},
                disable_filetype = { "MiniPick", "vim" },
            },
            config = function(_, opts)
                require("nvim-autopairs").setup(opts)
                require("nvim-autopairs.completion.cmp").on_confirm_done()(require("cmp"))
            end,
        },

        -- Cmp sources
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    },
    opts = function()
        return require("plugins.configs.cmp")
    end,
}

-- ─── Copilot ─────────────────────────────────────────────────────────────
local copilot = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
    },
    build = ":Copilot auth",
}

local copilot_cmp = {
    "zbirenbaum/copilot-cmp",
    dependencies = { copilot },
    event = "InsertEnter",
    opts = {},
    config = function()
        require("copilot_cmp").setup()
    end,
}

local copilot_chat = {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { copilot, plenary },
    cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatReset" },
    opts = { model = "claude-3.5-sonnet" },
}
-- Only build tiktoken on Linux/macOS
if vim.fn.has("linux") == 1 or vim.fn.has("mac") == 1 then
    copilot_chat.build = "make tiktoken"
end

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
    copilot,
    copilot_cmp,
    copilot_chat,
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
