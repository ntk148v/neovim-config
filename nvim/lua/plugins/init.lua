--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins.init.lua
-- Description: Custom plugins configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Custom plugin configs
local modules = {'plugins.statusline', 'plugins.nvim-tree', 'plugins.nvim-treesitter', 'plugins.comment',
                 'plugins.nvim-telescope', 'plugins.nvim-autopairs', 'plugins.colorscheme', 'plugins.lsp',
                 'plugins.nvim-colorizer', 'plugins.term', 'plugins.gitsigns'}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(('Error loading %s...\n\n%s'):format(mod, err))
    end
end

