--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/neoterm.lua
-- Description: Floating terminal configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
return { -- Floating terminal
{
    "itmecho/neoterm.nvim",
    opts = {
        clear_on_run = true, -- run clear command before user specified commands
        mode = "horizontal", -- vertical/horizontal/fullscreen
        noinsert = false -- disable entering insert mode when opening the neoterm window
    },
    config = function(_, opts)
        require("neoterm").setup(opts)
    end
}}
