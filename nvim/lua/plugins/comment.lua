--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/comment.lua
-- Description: nvim comment config
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
return {{
    -- Smart and powerful comment plugin for neovim.
    -- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
    "numToStr/Comment.nvim",
    opts = {
        active = true,
        on_config_done = nil,
        -- Add a space b/w comment and the line
        -- @type boolean
        padding = true,

        -- Whether cursor should stay at the
        -- same position. Only works in NORMAL
        -- mode mappings
        sticky = true,

        -- Lines to be ignored while comment/uncomment.
        -- Could be a regex string or a function that returns a regex string.
        -- Example: Use "^$" to ignore empty lines
        -- @type string|function
        ignore = "^$",

        -- Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
        -- @type table
        mappings = {
            -- operator-pending mapping
            -- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
            basic = true,
            -- Extra mapping
            -- Includes `gco`, `gcO`, `gcA`
            extra = true
        },

        -- LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
        -- @type table
        toggler = {
            -- line-comment toggle
            line = "mm",
            -- block-comment toggle
            block = "mbm"
        },

        -- LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
        -- @type table
        opleader = {
            -- line-comment opfunc mapping
            line = "m",
            -- block-comment opfunc mapping
            block = "mb"
        },

        -- LHS of extra mappings
        -- @type table
        extra = {
            -- Add comment on the line above
            above = "mO",
            -- Add comment on the line below
            below = "mo",
            -- Add comment at the end of line
            eol = "mA"
        },

        -- Pre-hook, called before commenting the line
        -- @type function|nil
        pre_hook = pre_hook,

        -- Post-hook, called after commenting is done
        -- @type function|nil
        post_hook = nil
    },
    ---@param opts TSConfig
    config = function(_, opts)
        require("Comment").setup(opts)
    end
}}
