--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/cmp.lua
-- Description: cmp configuration
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local cmp = require "cmp"

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
    java = false        -- Don't check treesitter on java
  },

  -- Don't add pairs if it already has a close pair in the same line
  enable_check_bracket_line = false,

  -- Don't add pairs if the next char is alphanumeric
  ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" }
})

-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

local function border(hl_name)
  return { { "╭", hl_name }, { "─", hl_name }, { "╮", hl_name }, { "│", hl_name }, { "╯", hl_name },
    { "─", hl_name }, { "╰", hl_name }, { "│", hl_name } }
end

local options = {
  completion = {
    completeopt = "menu,menuone"
  },

  window = {
    completion = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
      scrollbar = false
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc"
    }
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },

  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = require("lspkind").cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
      mode = "symbol_text",
      symbol_map = {},
    }),
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true,
          true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
          "")
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        -- Avoid accidentally running on big files
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 1024 * 1024 then -- 1 Megabyte max
            return {}
          end
          return { buf }
        end
      }
    },
    { name = "nvim_lua" },
    { name = "path" }
  }
}
cmp.setup(options)
