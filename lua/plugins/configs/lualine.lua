--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/lualine.lua
-- Description: Pacman config for lualine
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local auto = require("lualine.themes.auto")
-- Apply transparency
for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
    if auto[mode] then
        for section, hl in pairs(auto[mode]) do
            -- reset to default (use scheme's default fg/bg)
            hl.fg = nil
            hl.bg = nil
            hl.gui = nil
        end
    end
end

-- Config
local config = {
    options = {
        theme = auto,
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { "Lazy", "NvimTree" },
    },

    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },

    tabline = {
        lualine_a = {
            {
                "buffers",
                max_length = vim.o.columns * 2 / 3,
                show_filename_only = false,
                mode = 0,
                right_padding = 5,
                left_padding = 5,
                use_mode_colors = true,
                buffers_color = {
                    -- Same values as the general color option can be used here.
                    active = {
                        fg = auto.normal.a.fg,
                        bg = auto.normal.a.bg,
                        gui = "bold",
                    },
                    inactive = {
                        fg = auto.normal.a.fg,
                        bg = auto.normal.a.bg,
                        gui = "italic",
                    },
                },
                symbols = {
                    modified = " ●",
                    alternate_file = "",
                    directory = "",
                },
            },
        },
    },

    extensions = { "nvim-tree", "mason", "fzf" },
}

-- Mode symbol
local function mode()
    local mode_map = {
        n = "N",
        i = "I",
        v = "V",
        [""] = "V",
        V = "V",
        c = "C",
        no = "N",
        s = "S",
        S = "S",
        ic = "I",
        R = "R",
        Rv = "R",
        cv = "C",
        ce = "C",
        r = "R",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
    }
    return mode_map[vim.fn.mode()] or "[?]"
end

-- Helpers
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

-- Left side
ins_left({ mode })

ins_left({
    "branch",
    icon = " ",
    color = { gui = "bold" },
})

ins_left({
    "diff",
    symbols = { added = " ", modified = "󰝤 ", removed = " " },
    cond = conditions.hide_in_width,
})

ins_left({
    function()
        return "%="
    end,
})

-- Right side
ins_right({
    function()
        local msg = "null"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " LSP:",
    color = { gui = "bold" },
})

ins_right({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hints = "󰛩 " },
    always_visible = false,
})

ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = true,
    color = { gui = "bold" },
})

ins_right({
    "location",
    color = { gui = "bold" },
})

ins_right({
    "progress",
    color = { gui = "bold" },
})

return config
