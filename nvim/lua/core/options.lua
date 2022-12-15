--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: core/options.lua
-- Description: General Neovim settings and configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local cmd = vim.cmd
-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
-- Global variables
local g = vim.g
local s = vim.s
local indent = 4

cmd([[
	filetype plugin indent on
]])

opt.backspace = {'eol', 'start', 'indent'}
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = {'(:)', '{:}', '[:]', '<:>'}
opt.syntax = 'enable'

-- indention
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent
opt.shiftround = true

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + {'*/node_modules/*', '*/.git/*', '*/vendor/*'}
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.laststatus = 2
opt.lazyredraw = true
opt.list = true
opt.listchars = {
    tab = '| ',
    trail = '·',
    extends = '»',
    precedes = '«',
    nbsp = '×'
}

-- Hide cmd line
opt.cmdheight = 0

opt.mouse = 'a'
opt.number = true
opt.scrolloff = 18
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = true

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.shortmess = opt.shortmess + {
    c = true
}

-- showmode
-- " By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
opt.showmode = false

-- perfomance
-- remember N lines in history
opt.history = 100
opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
-- signify default updatetime 4000ms is not good for async update
opt.updatetime = 100

-- theme - Enable 24-bit RGB colors
opt.termguicolors = true

-- persistent undo
-- Don't forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath('data') .. '/undo'
opt.undofile = true
opt.undodir = undodir
opt.undolevels = 1000
opt.undoreload = 10000

-- fold
opt.foldmethod = 'marker'
opt.foldlevel = 99

-- Disable builtin plugins
local disabled_built_ins = {"2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
                            "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
                            "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
                            "synmenu", "optwin", "compiler", "bugreport", "ftplugin"}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- Colorscheme
-- By default, use rose-pine
cmd('colorscheme rose-pine')
