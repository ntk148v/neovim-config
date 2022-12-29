"
"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" File              : lualine.vim
" Author            : Kien Nguyen-Tuan <kiennt2609@gmail.com>

" Config Treesitter
lua << END
require('nvim-treesitter.configs').setup{
    -- A list of parser names, or "all"
    ensure_installed = { "go", "python", "dockerfile", "json", "yaml", "markdown" },

    highlight = {
        enable = true
    },

    incremental_selection = {
        enable = true
    },

    indent = {
        enable = true
    },
}
END
