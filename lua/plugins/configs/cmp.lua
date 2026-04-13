--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/cmp.lua
-- Description: cmp configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return {}
end

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local options = {
    completion = {
        completeopt = "menu,menuone,noselect",
    },

    window = {
        completion = {
            -- Re-enable defaults, commenting out custom highlights that might hide text
            -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
            scrollbar = false,
        },
        documentation = {
            border = border("CmpDocBorder"),
            -- winhighlight = "Normal:CmpDoc",
        },
    },

    snippet = {
        expand = function(args)
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if luasnip_ok then
                luasnip.lsp_expand(args.body)
            end
        end,
    },

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            local lspkind_ok, lspkind = pcall(require, "lspkind")
            if lspkind_ok then
                return lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                    mode = "symbol_text",
                })(entry, vim_item)
            end
            return vim_item
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip_ok and luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip_ok and luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                    if byte_size > 1024 * 1024 then
                        return {}
                    end
                    return { buf }
                end,
            },
        },
        { name = "nvim_lua" },
        { name = "path" },
    }),
}

return options
