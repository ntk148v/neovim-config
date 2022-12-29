"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" File              : settings.vim
" Author            : Kien Nguyen-Tuan <kiennt2609@gmail.com>

filetype plugin indent on

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
if has('mouse')
    set mousemodel=extend
    set mouse=a
endif
" By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
set noshowmode
set foldmethod=indent
set foldlevel=99
set conceallevel=0
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
" set listchars=tab:>·,trail:~,extends:>,precedes:<
set listchars=tab:\|\ ,trail:~,extends:\|,precedes:\|
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
set wildoptions=pum
set pumblend=1
" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical
" unnamedplus is only available with the +X11 feature
if has('unnamedplus')
  set clipboard+=unnamedplus
end
set shortmess+=c
set signcolumn=yes

let g:is_posix = 1

"""""""""""""""""""""""""
" Vim color highlighting
"""""""""""""""""""""""""
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_virtualText = '▩'

"""""""""""""""""""""""""
" FZF configs
"""""""""""""""""""""""""
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

"""""""""""""""""""""""""
" Esearch config
"""""""""""""""""""""""""
let g:esearch = {
  \ 'adapter': 'rg',
  \ 'backend': 'nvim'
  \}
call esearch#out#win#map('<Enter>', 'tab')

let ayucolor="mirage"
let g:tokyonight_style = "night"
" set background=light

" Github tweak
let g:github_comment_style = "NONE"
let g:github_colors = {
        \ "bg": "#f5eee6"
      \ }
" Rose-pine tweak
lua << END
require('rose-pine').setup({
    dark_variant = 'main'
})
END
colo rose-pine

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let current_scheme = get(g:, 'colors_name', 'default')
if (has("termguicolors") && current_scheme != "wal" && current_scheme != "xcodelighthc")
  set termguicolors
endif
source $HOME/.config/nvim/custom/wal.vim

" Floating Term
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

" NERDTree config
let NERDTreeMinimalUI=1
let g:NERDSpaceDelims = 1

" Statusline
let chosen_statusline="lualine"
if (chosen_statusline == "lualine")
  let g:loaded_lightline = 0
  source $HOME/.config/nvim/custom/pacman_lualine.vim " Default
elseif (chosen_statusline == "lightline")
  source $HOME/.config/nvim/custom/lightline.vim
endif

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" editor.action.organizeImport code action will auto-format code and add
" missing imports
autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

" Custom icon for coc.nvim statusline
let g:coc_status_error_sign=" "
let g:coc_status_warning_sign=" "
let g:coc_snippet_next = '<tab>'
let g:coc_disable_startup_warning = 1

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

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


" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{StatusDiagnostic()}

lua << EOF
  require("zen-mode").setup {}
  require("nvim-autopairs").setup {}
EOF

source $HOME/.config/nvim/custom/nvim-treesitter.vim
