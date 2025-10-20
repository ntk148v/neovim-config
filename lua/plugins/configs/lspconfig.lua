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

-- Merge
merge_tables(formatting_servers, custom_formatting_servers)

local opts = {
    -- Automatically format on save
    autoformat = true,
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
        formatting_options = nil,
        timeout_ms = nil,
    },
    -- LSP Server Settings
    servers = formatting_servers,
    -- you can do any additional lsp server setup here
    -- return true if you don"t want this server to be setup with lspconfig
    setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
    },
}

local servers = opts.servers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
        if opts.setup[server](server, server_opts) then return end
    elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then return end
    end
    require("lspconfig")[server].setup(server_opts)
end

local mlsp = require "mason-lspconfig"
local available = {}
do
    local ok, result = pcall(mlsp.get_available_servers)
    if ok then
        available = result
    else
        vim.schedule(
            function()
                vim.notify(
                    "[mason-lspconfig] Failed to get available servers: " .. tostring(result),
                    vim.log.levels.WARN
                )
            end
        )
        available = {}
    end
end

local ensure_installed = {} ---@type string[]
for server, server_opts in pairs(servers) do
    if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
        else
            ensure_installed[#ensure_installed + 1] = server
        end
    end
end

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = ensure_installed,
    automatic_installation = true,
    -- Whether installed servers should automatically be enabled via `:h vim.lsp.enable()`.
    automatic_enable = true,
}
