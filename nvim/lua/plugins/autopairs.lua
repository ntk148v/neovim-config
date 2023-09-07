--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/autopairs.lua
-- Description: nvim-autopairs config
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
return {{
    -- Autopairs
    "windwp/nvim-autopairs",
    opts = {
        check_ts = true,
        ts_config = {
            lua = {"string"}, -- it will not add a pair on that treesitter node
            javascript = {"template_string"},
            java = false -- don"t check treesitter on java
        },

        -- Don"t add pairs if it already has a close pair in the same line
        enable_check_bracket_line = false,

        -- Don"t add pairs if the next char is alphanumeric
        ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
        fast_wrap = {},
        disable_filetype = {"TelescopePrompt", "vim"}
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
            map_char = {
                tex = ""
            }
        }))
    end
}}
