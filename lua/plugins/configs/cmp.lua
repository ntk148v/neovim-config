--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/cmp.lua
-- Description: blink.cmp configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local luasnip_ok, _ = pcall(require, "luasnip")

local options = {
    keymap = {
        preset = "default",
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        documentation = {
            auto_show = false,
        },
        list = {
            selection = {
                preselect = true,
                auto_insert = true,
            },
        },
    },

    snippets = {
        preset = luasnip_ok and "luasnip" or "vim.snippet",
    },

    appearance = {
        nerd_font_variant = "mono",
        border = border("CmpBorder"),
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
}

return options
