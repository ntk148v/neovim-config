--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/nvim-treesitter.lua
-- Description: nvim-treesitter configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or 'all'
    ensure_installed = {'go', 'python', 'dockerfile', 'json', 'yaml', 'markdown', 'html', 'scss', 'css'},

    highlight = {
        enable = true,
        use_languagetree = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
        highlight_current_scope = {
            enable = false
        }
    }
}
