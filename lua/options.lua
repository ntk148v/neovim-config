--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: options.lua
-- Description: General Neovim settings and configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local opt = vim.opt
local g = vim.g

-- ─── Leader ──────────────────────────────────────────────────────────────
g.mapleader = " "
g.maplocalleader = " "

-- ─── Clipboard ───────────────────────────────────────────────────────────
-- Schedule to avoid slowing up startup
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- ─── General ─────────────────────────────────────────────────────────────
opt.backup = false
opt.breakindent = true
opt.confirm = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --smart-case"
opt.history = 500
opt.inccommand = "split"
opt.lazyredraw = false -- deprecated; use eventignore when needed
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.mouse = "a"
opt.redrawtime = 1500
opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
opt.showmode = false
opt.sidescrolloff = 3
opt.syntax = "enable"
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.writebackup = false

-- ─── Indentation ─────────────────────────────────────────────────────────
local indent = 4
opt.autoindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- ─── Search ──────────────────────────────────────────────────────────────
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = { "*/node_modules/*", "*/.git/*", "*/vendor/*", "*/.hg/*", "*/.svn/*" }
opt.wildmenu = true

-- ─── UI ──────────────────────────────────────────────────────────────────
opt.cmdheight = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.laststatus = 3 -- global statusline (more performant than 2)
opt.number = true
opt.pumheight = 10
opt.scrolloff = 18
opt.showtabline = 2
opt.signcolumn = "yes"
opt.shortmess:append({ c = true, W = true, I = true })
opt.splitbelow = true
opt.splitkeep = "cursor"
opt.splitright = true
opt.winborder = "rounded"
opt.winminwidth = 5
opt.wrap = true

-- ─── List chars ──────────────────────────────────────────────────────────
opt.list = true
opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×",
}

-- ─── Folds ───────────────────────────────────────────────────────────────
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldnestmax = 10

-- ─── Swap / Undo ─────────────────────────────────────────────────────────
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undolevels = 10000
opt.undoreload = 10000

-- ─── Backspace ───────────────────────────────────────────────────────────
opt.backspace = { "eol", "start", "indent" }

-- ─── Completion ──────────────────────────────────────────────────────────
opt.complete = ".,w,b,kspell"

-- ─── Disable unnecessary built-in plugins for speed ─────────────────────
local disabled = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "compiler",
    "bugreport",
    "ftplugin",
}
for _, name in ipairs(disabled) do
    g["loaded_" .. name] = 1
end

-- ─── Colorscheme ─────────────────────────────────────────────────────────
-- Will be set by lazy.nvim after plugins are installed

-- ─── Diagnostics (Neovim 0.11+) ─────────────────────────────────────────
if vim.fn.has("nvim-0.11") > 0 then
    vim.diagnostic.config({
        severity_sort = true,
        underline = false,
        update_in_insert = false,
        virtual_lines = { current_line = true },
    })
end

-- ─── Popup menu border (Neovim 0.12+) ───────────────────────────────────
if vim.fn.has("nvim-0.12") > 0 then
    opt.pumborder = "rounded"
end
