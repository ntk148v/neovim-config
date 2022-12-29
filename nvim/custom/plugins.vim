"
"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" File              : plugins.vim
" Author            : Kien Nguyen-Tuan <kiennt2609@gmail.com>

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')
" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'
" Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" A tree explorer plugin for vim.
Plug 'preservim/nerdtree'
" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'
" A blazing fast and easy to configure neovim statusline plugin written in pure lua.
Plug 'nvim-lualine/lualine.nvim'
" LSP Progress lualine componenet
Plug 'arkav/lualine-lsp-progress'
" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'
" Vim plugin, insert or delete brackets, parens, quotes in pair
" Plug 'ntk148v/auto-pairs'
" autopairs for neovim written by lua
Plug 'windwp/nvim-autopairs'
" :flashlight: Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'
" Vim plugin for intensely nerdy commenting powers
Plug 'scrooloose/nerdcommenter'
" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Perform search in files easily
Plug 'eugen0329/vim-esearch'
" :cherry_blossom: A command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
" fzf :heart: vim
Plug 'junegunn/fzf.vim'
" hexokinase.vim - (Neo)Vim plugin for asynchronously displaying the colours in the file (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'
" Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
" Plug 'SirVer/ultisnips'
" vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" 🧘  Distraction-free coding for Neovim
Plug 'folke/zen-mode.nvim'
" Colorscheme
" Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more.
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" An arctic, north-bluish clean and elegant Vim theme.
Plug 'arcticicestudio/nord-vim'
" Adaptation of VS Code horizon colorscheme for Vim
Plug 'ntk148v/vim-horizon'
" :antarctica: Bluish color scheme for Vim and Neovim
Plug 'cocopon/iceberg.vim'
" Modern theme for modern VIMs
Plug 'ayu-theme/ayu-vim'
" 🧛 Dark theme for Vim
Plug 'dracula/vim'
" 🏙  A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
Plug 'folke/tokyonight.nvim'
" 🍨 Soothing pastel theme for NeoVim
Plug 'catppuccin/nvim'
" High Contrast & Vivid Color Scheme based on Monokai Pro
Plug 'sainnhe/sonokai'
" Soothing color scheme for your favorite [best] text editor
Plug 'drewtempelmeyer/palenight.vim'
" Yet another minimal Vim/Neovim colorscheme
Plug 'ntk148v/komau.vim'
" Github theme for Neovim and Terminals written in Lua
Plug 'projekt0n/github-nvim-theme'
" Xcode 11’s dark and light colourschemes for Vim
Plug 'arzg/vim-colors-xcode'
" NeoSolarized: A fixed solarized colorscheme for better truecolor support.
Plug 'overcache/NeoSolarized'
" Light & Dark vim colorschemes inpired by Google's Material Design
Plug 'NLKNguyen/papercolor-theme'
" A port of everblush.vim but written in lua
Plug 'Everblush/everblush.nvim', { 'as': 'everblush' }
Plug 'shaunsingh/oxocarbon.nvim', { 'do': './install.sh' }
" A port of decay colorscheme for neovim using lua :3
Plug 'decaycs/decay.nvim', { 'as': 'decay' }
" Soho vibes for Neovim
Plug 'rose-pine/neovim', { 'as': 'rose-pine', 'commit': '69dca24ba7f8e74f1e6f0bacbc93481ac4047f2e' }

Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
call plug#end()
