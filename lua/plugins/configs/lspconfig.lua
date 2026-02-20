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
local formatting_servers = {
    jsonls = {},
    dockerls = {},
    bashls = {},
    gopls = {},
    ruff_lsp = {},
    vimls = {},
    yamlls = {},
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

merge_tables(formatting_servers, custom_formatting_servers)

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
    }, formatting_servers[server] or {})
    require("lspconfig")[server].setup(server_opts)
end

local mlsp = require("mason-lspconfig")
local available = {}
do
    local ok, result = pcall(mlsp.get_available_servers)
    if ok then
        available = result
    else
        vim.schedule(function()
            vim.notify("[mason-lspconfig] Failed to get available servers: " .. tostring(result), vim.log.levels.WARN)
        end)
        available = {}
    end
end

local ensure_installed = {}
for server, server_opts in pairs(formatting_servers) do
    if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
        else
            ensure_installed[#ensure_installed + 1] = server
        end
    end
end

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
    automatic_enable = true,
})
