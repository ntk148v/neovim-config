--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: autocmds.lua
-- Description: Autocommand functions
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local grp = {
    general = augroup("General", { clear = true }),
    ft = augroup("FileTypeSettings", { clear = true }),
    colors = augroup("Colors", { clear = true }),
}

-- ─── Highlight on Yank ──────────────────────────────────────────────────
autocmd("TextYankPost", {
    group = grp.general,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 })
    end,
})

-- ─── Strip Trailing Whitespace on Save ──────────────────────────────────
autocmd("BufWritePre", {
    group = grp.general,
    pattern = "*",
    callback = function()
        -- Remove trailing whitespace using Lua (faster than %s)
        local view = vim.fn.winsaveview()
        vim.cmd([[silent! %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

-- ─── Format on Save ─────────────────────────────────────────────────────
autocmd("BufWritePre", {
    group = grp.general,
    pattern = "*",
    callback = function()
        require("conform").format({ lsp_fallback = true })
    end,
})

-- ─── Disable formatoptions flags ────────────────────────────────────────
autocmd("BufEnter", {
    group = grp.general,
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- ─── Filetype-specific settings ─────────────────────────────────────────
autocmd("FileType", {
    group = grp.ft,
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd("FileType", {
    group = grp.ft,
    pattern = { "python", "rst", "c", "cpp" },
    command = "setlocal colorcolumn=80",
})

autocmd("FileType", {
    group = grp.ft,
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- ─── Colorscheme tweaks ─────────────────────────────────────────────────
autocmd("ColorScheme", {
    group = grp.colors,
    callback = function()
        local hi = function(group, spec)
            vim.api.nvim_set_hl(0, group, spec)
        end
        hi("Lualine_c_normal", { bg = "none" })
        hi("StatusLine", { bg = "none" })
        hi("StatusLineNC", { bg = "none" })
        hi("TabLineFill", { bg = "none" })
        hi("TabLineSel", { bg = "none" })
        hi("TabLine", { bg = "none" })
    end,
})
