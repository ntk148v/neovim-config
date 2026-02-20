--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: autocmds.lua
-- Description: Autocommand functions
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General", { clear = true })
local ft_settings = augroup("FileTypeSettings", { clear = true })
local colors = augroup("Colors", { clear = true })

autocmd("TextYankPost", {
    group = general,
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 1000,
        })
    end,
})

autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    callback = function()
        require("conform").format({ lsp_fallback = true })
    end,
})

autocmd("BufEnter", {
    group = general,
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
    group = ft_settings,
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd("Filetype", {
    group = ft_settings,
    pattern = { "python", "rst", "c", "cpp" },
    command = "set colorcolumn=80",
})

autocmd("Filetype", {
    group = ft_settings,
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

autocmd("ColorScheme", {
    group = colors,
    callback = function()
        vim.cmd([[hi Lualine_c_normal guibg=none]])
        vim.cmd([[hi StatusLine guibg=none]])
        vim.cmd([[hi StatusLineNC guibg=none]])
        vim.cmd([[hi TabLineFill guibg=none]])
        vim.cmd([[hi TabLineSel guibg=none]])
        vim.cmd([[hi TabLine guibg=none]])
    end,
})
