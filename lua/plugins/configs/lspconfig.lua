--
-- File: plugins/configs/lspconfig.lua
-- Description: LSP setup using native vim.lsp (Neovim 0.11+)
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local utils = require("utils")

-- Load custom server configs
local exist, custom = pcall(require, "custom")
local custom_servers = exist and type(custom) == "table" and custom.formatting_servers or {}

-- Default server configurations
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
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },
}

-- Merge custom server configs
utils.merge_tables(server_configs, custom_servers)

-- Get cmp capabilities
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok_cmp and cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    or vim.lsp.protocol.make_client_capabilities()

-- Register each server with vim.lsp.config()
local servers_to_ensure = {}
for server, config in pairs(server_configs) do
    if config then
        local final_config = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
        }, config == true and {} or config)

        -- Use native vim.lsp.config (Neovim 0.11+)
        vim.lsp.config(server, final_config)

        -- Track for mason installation
        if config.mason ~= false then
            servers_to_ensure[#servers_to_ensure + 1] = server
        end
    end
end

-- Set up mason-lspconfig to auto-install servers
-- mason-lspconfig's automatic_enable will call vim.lsp.enable() for us
require("mason-lspconfig").setup({
    ensure_installed = servers_to_ensure,
    automatic_enable = true,
})
