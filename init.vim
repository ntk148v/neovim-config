set nocompatible
filetype off
set hidden
set showtabline=0

" Specify a directory for plugins
set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')

" Add all your plugins here
"-------------------=== Code/Project navigation ===-------------

Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'neomake/neomake'                    " Asynchronous Linting and Make Framework
Plug 'Shougo/deoplete.nvim'               " Asynchronous Completion
Plug 'vim-ctrlspace/vim-ctrlspace'        " Tabs/Buffers/Fuzzy/Workspaces/Bookmarks
Plug 'mileszs/ack.vim'                    " Ag/Grep
Plug 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes'     " Themes for airline
Plug 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'majutsushi/tagbar'                  " Class/module browser

"-------------------=== Fancy things ===----------------------------
Plug 'flazz/vim-colorschemes'             " Colorschemes
Plug 'jreybert/vimagit'                   " Git Operations
Plug 'kien/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'chriskempson/base16-vim'            " Base 16 colors
Plug 'ryanoasis/vim-devicons'             " Dev Icons

"-------------------=== Snippets support ===------------------------
Plug 'honza/vim-snippets'                 " snippets repo
Plug 'Raimondi/delimitMate'               " Auto-close brackets

"-------------------=== Languages support ===-----------------------
Plug 'scrooloose/nerdcommenter'           " Easy code documentation
Plug 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plug 'w0rp/ale'

"-------------------=== Python ===----------------------------------
Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
Plug 'jmcantrell/vim-virtualenv'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()
filetype on
filetype plugin on
filetype plugin indent on

"-------------------
" General settings
"-------------------
set guicursor=
set encoding=utf8
set t_Co=256
let base16colorspace=256
set background=dark
set guifont=DroidSansMono\ Nerd\ Font\ 12
set termguicolors
colorscheme onedark
syntax enable                             " enable syntaax highlighting

"let g:loaded_python_provider=1
let g:python2_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'
set shell=/bin/zsh
set number                                " show line numbers
set ruler
set ttyfast                               " terminal acceleration

set tabstop=4                             " 4 whitespaces for tabs visual presentation
set shiftwidth=4                          " shift lines by 4 spaces
set smarttab                              " set tabs for a shifttabs logic
set expandtab                             " expand tabs into spaces
set autoindent                            " indent when moving to the next line

set cursorline                            " show line under the cursor's line
set showmatch                             " show matching part of bracket parts (), [], {}

set enc=utf-8                             " utf-8 by default

set nobackup                              " no backup files
set noswapfile

set backspace=indent,eol,start            " backspace removes all

set scrolloff=20
set clipboard=unnamed                     " use system clipboard
set listchars=tab:>\ ,trail:•,extends:#,nbsp:." Indent guides settings

" Auto update
set autoread
set autowrite

" Use mouse
if has('mouse')
    set mouse=a
endif

" -----------------------
" Tab / Buffers settings
" ----------------------
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q: SyntasticCheck # <CR> :bp <BAR> bd #<CR>

" -----------------------
" Neomake settings
" -----------------------
call neomake#configure#automake('w')
let g:neomake_open_list=2

" -----------------------
" Deoplete settings
" -----------------------
let g:deoplete#enable_at_startup=1

" -----------------------
" Search settings
" -----------------------
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

" ---------------------------
" Comfortable Motion settings
" ---------------------------
let g:comfortable_motion_scroll_down_key="j"
let g:comfortable_motion_scroll_up_key="k"
let g:comfortable_motion_no_default_key_mappings=1
let g:comfortable_motion_impulse_multiplier=25  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

" --------------------------
" Airline settings
" --------------------------
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"------------------------
" NERDTree settings
" -----------------------
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>

" -----------------------
" TagBar
" -----------------------
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose
nmap <F8> :TagbarToggle<CR>

" -----------------------
" NERDComment settings
" -----------------------

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" -----------------------
" DevIcon settings
" -----------------------
" loading the plugin 
let g:webdevicons_enable = 1

" adding the flags to NERDTree 
let g:webdevicons_enable_nerdtree = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs 
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags 
let g:webdevicons_conceal_nerdtree_brackets = 0

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 

" change the default character when no match found
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" disabled by default with no value
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 0

" -----------------------
" SnipMate settings
" -----------------------
let g:snippets_dir='~/.local/share/nvim/plugged/vim-snippets/snippets/'

" ----------------------------
" Rainbow Parentheses Autoload
" ----------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" -----------------------
" Python
" -----------------------

" python executables for different plugins
let g:pymode_python='python'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=8
augroup END

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'
let g:ale_sign_column_always=0
let g:ale_emit_conflict_warnings=0
let g:airline#extensions#ale#enabled = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:airline#extensions#tabline#enabled = 1

imap <F5> <Esc>:w<CR>:!clear;python %<CR>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
