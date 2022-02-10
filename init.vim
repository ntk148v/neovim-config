" File              : init.vim
" Author            : Kien Nguyen-Tuan <kiennt2609@gmail.com>

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
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
" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'
" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'ntk148v/auto-pairs'
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
Plug 'SirVer/ultisnips'
" vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets'
" 🌅  Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.
Plug 'folke/twilight.nvim'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" Colorscheme
" An arctic, north-bluish clean and elegant Vim theme.
Plug 'arcticicestudio/nord-vim'
" 🏙  A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
Plug 'folke/tokyonight.nvim'
call plug#end()

filetype plugin indent on

" ---- General config -----

" Todo file
autocmd BufNewFile,BufRead *.todo set syntax=todo
" Python file
autocmd BufRead,BufNewFile *.py setlocal textwidth=80
" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

set encoding=UTF-8
set hidden
set nobackup
set nowritebackup
set cursorline
" Uncomment it if you want to use mouse
" if has('mouse')
"     set mouse=a
" endif
" By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
set noshowmode
set foldmethod=indent
set foldlevel=99
set conceallevel=0
let g:is_posix = 1
set noswapfile
set nojoinspaces
set wrap
set linebreak
set number
set ttyfast
set laststatus=2
set ttimeout
set ttimeoutlen=10
set ignorecase
" Signify default updatetime 4000ms is not good for async update
set updatetime=100

" I don't use recording, don't judge me
map q <Nop>
inoremap jk <ESC>
vnoremap <M-/> <Esc>/\%V
nnoremap <ESC><ESC> :nohlsearch<CR>
" Word instead of character movement
" nnoremap L l
" nnoremap H h
" nnoremap l w
" nnoremap h b

vnoremap p "_dP

" Remap scrolling
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{StatusDiagnostic()}

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
if (has("termguicolors"))
    set termguicolors
endif
set background=dark
colo tokyonight
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set listchars=tab:>·,trail:~,extends:>,precedes:<
set list
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set smarttab
set expandtab
set autoindent
set smartindent
" Persistent undo
" Don't forget mkdir folder $HOME/.local/share/nvim/undo
set undofile
set undodir=$HOME/.local/share/nvim/undo
set undolevels=1000
set undoreload=10000
set updatetime=300
" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical
set shortmess+=c
set signcolumn=yes
set clipboard=unnamed
set wildoptions=pum
set pumblend=1

" Vim color highlighting
let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_virtualText = '▩'

" FZF config
let g:fzf_layout = { 'window': {
      \ 'width': 0.9,
      \ 'height': 0.7,
      \ 'highlight': 'Comment',
      \ 'rounded': v:false } }
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Esearch config
let g:esearch = {
  \ 'adapter': 'rg',
  \ 'backend': 'nvim'
  \}
call esearch#out#win#map('<Enter>', 'tab')

" Custom icon for coc.nvim statusline
let g:coc_status_error_sign=" "
let g:coc_status_warning_sign=" "


" --------- Floating  ---------
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatWinBorder guifg=#87bb7c
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatWinBorder')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

" ------- Key binding ---------
let mapleader=" "
map mm <Plug>NERDCommenterToggle
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nnoremap <Leader>1 :diffget 1<CR>:diffupdate<CR>
nnoremap <Leader>2 :diffget 2<CR>:diffupdate<CR>
nnoremap <Leader>s :Ack<CR>
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>
nnoremap <Leader>wh :wincmd h<CR>
nnoremap <Leader>wl :wincmd l<CR>
nnoremap <Leader>wk :wincmd k<CR>
nnoremap <Leader>wj :wincmd j<CR>
nnoremap <Leader>w= :wincmd =<CR>
nnoremap <Leader>wb :e#<CR>
nnoremap <Leader>qq :bd<CR>
nnoremap <Leader>qk :call DeleteCurrentFileAndBuffer()<CR>
nnoremap <Leader>ss :mksession! .vimsession<CR>
nnoremap <Leader>sr :so .vimsession<CR>
nnoremap <Leader><Leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>n :NERDTree<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
" Tabs
nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>tc :tabe<CR>
nnoremap <Leader>tx :tabclose<CR>
" Buffers
nnoremap <Leader>qq :bd<CR>
" Open terminal
nnoremap <Leader>at :call FloatTerm()<CR>
" Open tig, yes TIG, A FLOATING TIGGGG!!!!!!
nnoremap <Leader>ag :call FloatTerm('"tig"')<CR>
nnoremap <silent> <Leader>pf :Files<CR>
nnoremap <silent> <Leader>pb :Buffers<CR>
nnoremap <silent> <Leader>pr :History<CR>
nnoremap <silent> <c-\> :call esearch#init()<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> \ :Rg<CR>
nnoremap <silent> <c-o> :CocList outline<CR>
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" ------ NERDTree config ------
let NERDTreeMinimalUI=1
let g:NERDSpaceDelims = 1

" ------ Lightline ------
function! DeleteCurrentFileAndBuffer()
  call delete(expand('%'))
  bdelete!
endfunction

function! DrawGitBranchInfo()
  let branch = fugitive#head()
  return len(branch) > 0 ? " " . branch : ""
endfunction

function! MyFiletype()
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
  return ''
endfunction

function! LightLineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = len(parent) > 0 ? parent . '/' . s : s
    elseif i == 1
      let name = s
    else
      let part = strpart(s, 0, 10)
      let name = len(parent) > 0 ? parent . '/' . part : part
    endif
    let i += 1
  endfor
  return name
endfunction

let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ ['mode'], ['filename'] ],
      \   'right': [ [], ['cocstatus', 'lineinfo', 'icongitbranch'] ]
      \ },
      \ 'inactive': {
      \   'left': [ ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': ' %2p%% %3l:%-2v' },
      \ 'component_function': {
      \   'fileicon': 'MyFiletype',
      \   'icongitbranch': 'DrawGitBranchInfo',
      \   'iconline': 'DrawLineInfo',
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'filename': 'LightLineFilename',
      \ },
      \ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_disable_startup_warning = 1

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Remap for format selected region
xmap <leader><leader>f  <Plug>(coc-format-selected)
nmap <leader><leader>f  <Plug>(coc-format-selected)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>ar  <Plug>(coc-rename)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

lua << EOF
  require("twilight").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
