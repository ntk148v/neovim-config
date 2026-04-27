--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/treesitter.lua
-- Description: nvim-treesitter configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`

-- load custom parsers
local exist, custom = pcall(require, "custom")
local custom_parsers = exist and type(custom) == "table" and custom.treesitter_parsers or {}

-- ensure basic parser are installed
local basic_parsers = {
    "go",
    "python",
    "dockerfile",
    "json",
    "yaml",
    "markdown",
    "html",
    "css",
    "vim",
    "lua",
    "luadoc",
}

local parsers = vim.tbl_deep_extend("force", basic_parsers, custom_parsers)

require("nvim-treesitter").install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
    -- enables syntax highlighting and other treesitter features
    pcall(vim.treesitter.start, buf, language)

    -- enables treesitter based folds
    -- for more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

    -- enables treesitter based indentation
    if has_indent_query then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

local available_parsers = require("nvim-treesitter").get_available()
local skip_filetypes = { "minifiles", "MiniPick", "NvimTree", "lazy", "mason", "help", "qf" }

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf, filetype = args.buf, args.match

        -- Skip known non-treesitter filetypes early
        if vim.tbl_contains(skip_filetypes, filetype) or filetype == "" then
            return
        end

        local language = vim.treesitter.language.get_lang(filetype)
        if not language or language == "" or language == "minifiles" then
            return
        end

        local installed_parsers = require("nvim-treesitter").get_installed("parsers")

        if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require("nvim-treesitter").install(language):await(function()
                treesitter_try_attach(buf, language)
            end)
        end
    end,
})

-- Explicitly disable treesitter for minifiles to be extra safe
vim.api.nvim_create_autocmd("FileType", {
    pattern = "minifiles",
    callback = function(args)
        pcall(vim.treesitter.stop, args.buf)
    end,
})
