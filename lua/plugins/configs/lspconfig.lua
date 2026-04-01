--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/lspconfig.lua
-- Description: LSP setup and config
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
local merge_tables = require("utils").merge_tables

local exist, custom = pcall(require, "custom")
local custom_formatting_servers = exist and type(custom) == "table" and custom.formatting_servers or {}
local server_configs = {
  jsonls = {},
  dockerls = {},
  bashls = {},
  gopls = {},
  ruff = {},
  vimls = {},
  yamlls = {},
  ty = {},
  marksman = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

merge_tables(server_configs, custom_formatting_servers)

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

for server, config in pairs(server_configs) do
  if config then
    vim.lsp.config(
      server,
      vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, config == true and {} or config)
    )
  end
end

local mlsp = require("mason-lspconfig")

local ensure_installed = {}
for server, server_opts in pairs(server_configs) do
  if server_opts then
    server_opts = server_opts == true and {} or server_opts
    if server_opts.mason ~= false then
      ensure_installed[#ensure_installed + 1] = server
    end
  end
end

require("mason-lspconfig").setup({
  ensure_installed = ensure_installed,
  automatic_enable = true,
})
