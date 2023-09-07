--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/lualine.lua
-- Description: Pacman config for lualine
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Credit: shadmansaleh & his evil theme: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
return {{
    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    "nvim-lualine/lualine.nvim",
    config = function(_)
        local lualine = require("lualine")
        local lualine_require = require("lualine_require")

        function loadcolors()
            -- Rose-pine palette
            local rosepine = require("rose-pine.palette")
            local colors = {
                bg = rosepine.base,
                fg = rosepine.text,
                yellow = rosepine.gold,
                cyan = rosepine.foam,
                black = rosepine.subtled,
                green = rosepine.pine,
                white = rosepine.text,
                magenta = rosepine.iris,
                blue = rosepine.rose,
                red = rosepine.love
            }

            -- Try to load pywal colors
            local modules = lualine_require.lazy_require {
                utils_notices = "lualine.utils.notices"
            }
            local sep = package.config:sub(1, 1)
            local wal_colors_path = table.concat({os.getenv("HOME"), ".cache", "wal", "colors.sh"}, sep)
            local wal_colors_file = io.open(wal_colors_path, "r")

            if wal_colors_file == nil then
                modules.utils_notices.add_notice("lualine.nvim: " .. wal_colors_path .. " not found")
                return colors
            end

            local ok, wal_colors_text = pcall(wal_colors_file.read, wal_colors_file, "*a")
            wal_colors_file:close()

            if not ok then
                modules.utils_notices.add_notice("lualine.nvim: " .. wal_colors_path .. " could not be read: " ..
                                                     wal_colors_text)
                return colors
            end

            local wal = {}

            for line in vim.gsplit(wal_colors_text, "\n") do
                if line:match("^[a-z0-9]+='#[a-fA-F0-9]+'$") ~= nil then
                    local i = line:find("=")
                    local key = line:sub(0, i - 1)
                    local value = line:sub(i + 2, #line - 1)
                    wal[key] = value
                end
            end

            -- Color table for highlights
            colors = {
                bg = wal.background,
                fg = wal.foreground,
                yellow = wal.color3,
                cyan = wal.color4,
                black = wal.color0,
                green = wal.color2,
                white = wal.color7,
                magenta = wal.color5,
                blue = wal.color6,
                red = wal.color1
            }

            return colors
        end

        local colors = loadcolors()

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end
        }

        -- Config
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = "",
                section_separators = "",
                disabled_filetypes = {"Lazy", "NvimTree"},
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = {
                        c = {
                            fg = colors.fg,
                            bg = colors.bg
                        }
                    },
                    inactive = {
                        c = {
                            fg = colors.fg,
                            bg = colors.bg
                        }
                    }
                }
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {}
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {}
            }
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            -- mode component
            function()
                return "▶"
            end,
            color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    [""] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.yellow,
                    S = colors.yellow,
                    [""] = colors.yellow,
                    ic = colors.yellow,
                    R = colors.white,
                    Rv = colors.white,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ["r?"] = colors.cyan,
                    ["!"] = colors.red,
                    t = colors.red
                }
                return {
                    fg = mode_color[vim.fn.mode()]
                }
            end
        }

        ins_left {
            "filename",
            cond = conditions.buffer_not_empty,
            color = {
                fg = colors.magenta,
                gui = "bold"
            }
        }

        ins_left {
            "branch",
            icon = " ",
            color = {
                fg = colors.blue,
                gui = "bold"
            }
        }

        ins_left {
            "diff",
            -- Is it me or the symbol for modified us really weird
            symbols = {
                added = " ",
                modified = " ",
                removed = " "
            },
            diff_color = {
                added = {
                    fg = colors.green
                },
                modified = {
                    fg = colors.yellow
                },
                removed = {
                    fg = colors.red
                }
            },
            cond = conditions.hide_in_width
        }

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it"s any number greater then 2
        ins_left {function()
            return "%="
        end}

        ins_right {
            -- Lsp server name .
            function()
                local msg = "null"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = " LSP:",
            color = {
                fg = colors.cyan,
                gui = "bold"
            }
        }

        ins_right {
            "diagnostics",
            sources = {"nvim_diagnostic"},
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hints = "󰛩 ",
            },
            diagnostics_color = {
                color_error = {
                    fg = colors.red
                },
                color_warn = {
                    fg = colors.yellow
                },
                color_info = {
                    fg = colors.cyan
                },
                color_hints = {
                    fg = colors.magenta
                }
            },
            always_visible = true
        }

        ins_right {
            "o:encoding", -- option component same as &encoding in viml
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = {
                fg = colors.green,
                gui = "bold"
            }
        }

        ins_right {
            "fileformat",
            fmt = string.upper,
            icons_enabled = true,
            color = {
                fg = colors.green,
                gui = "bold"
            }
        }

        ins_right {
            "location",
            color = {
                fg = colors.fg,
                gui = "bold"
            }
        }

        ins_right {
            "progress",
            color = {
                fg = colors.fg,
                gui = "bold"
            }
        }

        -- Now don"t forget to initialize lualine
        lualine.setup(config)
    end
}}
