--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/colorizer.lua
-- Description: nvim-colorizer config
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
return { -- colorizer
{
    "norcalli/nvim-colorizer.lua",
    config = function(_)
        require("colorizer").setup()

        -- execute colorizer as soon as possible
        vim.defer_fn(function()
            require("colorizer").attach_to_buffer(0)
        end, 0)
    end
}}
