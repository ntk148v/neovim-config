--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: options.lua
-- Description: General Neovim settings and configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local cmd = vim.cmd
-- Set options (global/buffer/windows-scoped)
local o = vim.opt
-- Global variables
local g = vim.g
local indent = 4

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
g.mapleader = " "
g.maplocalleader = " "

cmd([[
	filetype plugin indent on
]])

-- Sync clipboard between Neovim and the system.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
o.breakindent = true
o.breakindentopt = "list:-1"

o.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
o.fileencoding = "utf-8" -- the encoding written to a file
o.encoding = "utf-8" -- the encoding
o.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
o.syntax = "enable"

-- indention
o.autoindent = true -- auto indentation
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = indent -- the number of spaces inserted for each indentation
o.smartindent = true -- make indenting smarter
o.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
o.tabstop = indent -- insert 2 spaces for a tab
o.shiftround = true -- use multiple of shiftwidth when indenting with "<" and ">"

-- tabline
o.showtabline = 2 -- always show tabs
o.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
-- search
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns unless \C or one or more capital letters in the search term
o.smartcase = true -- smart case
o.wildignore = o.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
o.wildmenu = true -- make tab completion for files/buffers act like bash
o.inccommand = "split" -- review substitutions live, as you type

-- ui
o.cursorline = true -- highlight the current line
o.laststatus = 2 -- only the last window will always have a status line
o.lazyredraw = true -- don"t update the display while executing macros
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
o.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
o.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×",
}

-- Enable pumborder feature if the current nvim version is 0.12+
if vim.fn.has("nvim-0.12") > 0 then
    -- pum
    o.pumborder = "rounded" -- popup menu (pum) border style
    o.pumheight = 10
end

-- window
vim.opt.winborder = "rounded" -- rounded border for all floating windows
vim.opt.winminwidth = 5

-- Hide cmd line
o.cmdheight = 0 -- more space in the neovim command line for displaying messages

o.mouse = "a" -- allow the mouse to be used in neovim
o.number = true -- set numbered lines
-- opt.relativenumber = true -- set relative numbered lines, to help with jumping.
o.scrolloff = 18 -- minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.splitbelow = true -- open new split below
o.splitright = true -- open new split to the right
o.splitkeep = "cursor" -- stabilize the screen layout when opening, closing, or resizing window splits
o.wrap = true -- display a wrapped line

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- backups
o.backup = false -- create a backup file
o.swapfile = false -- creates a swapfile
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- autocomplete
o.complete = ".,w,b,kspell"
o.completeopt = { "menu", "menuone", "noselect", "fuzzy" } -- mostly just for cmp
o.shortmess = o.shortmess + {
    c = true,
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
o.showmode = false

-- grep
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep --smart-case"

-- perfomance
-- remember N lines in history
o.history = 100 -- keep 100 lines of history
o.redrawtime = 1500
o.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 10
o.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
o.undofile = true -- enable persistent undo
o.undodir = undodir
o.undolevels = 1000
o.undoreload = 10000

-- fold
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldmethod = "expr"
o.foldlevel = 99
o.foldnestmax = 10
o.foldtext = ""

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
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
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- Colorscheme
-- By default, use rose-pine
cmd.colorscheme("rose-pine")

-- Enable virtual_lines feature if the current nvim version is 0.11+
if vim.fn.has("nvim-0.11") > 0 then
    vim.diagnostic.config({
        severity_sort = true,
        underline = false,
        update_in_insert = false,

        -- Alternatively, customize specific options
        virtual_lines = {
            -- Only show virtual line diagnostics for the current cursor line
            current_line = true,
        },
    })
end
