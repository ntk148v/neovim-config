return { -- Rose-pine - Soho vibes for Neovim
{
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    opts = {
        dark_variant = 'main'
    }
}, -- Github - Github's Neovim themes
{
    'projekt0n/github-nvim-theme',
    lazy = true,
    opts = {
        theme_style = "dark",
        function_style = "italic",
        sidebars = {"qf", "vista_kind", "terminal", "packer"},

        -- Change the "hint" color to the "orange" color, and make the "error" color bright red
        colors = {
            hint = "orange",
            error = "#ff0000"
        },

        -- Overwrite the highlight groups
        overrides = function(c)
            return {
                htmlTag = {
                    fg = c.red,
                    bg = "#282c34",
                    sp = c.hint,
                    style = "underline"
                },
                DiagnosticHint = {
                    link = "LspDiagnosticsDefaultHint"
                },
                -- this will remove the highlight groups
                TSField = {}
            }
        end
    }
}, -- Tokyonight- A clean, dark Neovim theme written in Lua, with support for lsp,
-- treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
{
    'folke/tokyonight.nvim',
    lazy = true
}}
