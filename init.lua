if vim.fn.has("nvim-0.12") == 0 then
    error("Need Neovim 0.12+ in order to use this config")
end

for _, cmd in ipairs({ "git", "rg", { "fd", "fdfind" } }) do
    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
    local commands = type(cmd) == "string" and { cmd } or cmd
    ---@cast commands string[]
    local found = false

    for _, c in ipairs(commands) do
        if vim.fn.executable(c) == 1 then
            name = c
            found = true
        end
    end

    if not found then
        error(("`%s` is not installed"):format(name))
    end
end

vim.opt.termguicolors = true
-- Disable annoying deprecated message
vim.deprecate = function() end

-- Setup leanpack.nvim plugin manager
vim.pack.add({ { src = "https://github.com/ntk148v/leanpack.nvim" } })

-- Load configurations in correct order
-- options and mappings must load before plugins (leader key, etc.)
for _, mod in ipairs({ "options", "mappings", "autocmds" }) do
    local ok, err = pcall(require, mod)
    if not ok then
        vim.api.nvim_err_writeln("Failed to load " .. mod .. "\n\n" .. tostring(err))
    end
end

-- Setup leanpack with import from lua/plugins/
require("leanpack").setup({
    { import = "plugins" },
    defaults = {
        lazy = true,
    },
    performance = {
        vim_loader = true,
        rtp_prune = true,
    },
})

-- Load custom configurations if they exist
-- Must be loaded last to allow overriding plugin defaults
local ok, custom = pcall(require, "custom")
if ok and type(custom) == "table" then
    -- Override custom formatting servers if defined
    if type(custom.formatting_servers) == "table" then
        -- Can be used to override LSP servers
    end
    -- Run custom configs last (e.g., colorscheme override)
    if type(custom.configs) == "function" then
        custom.configs()
    end
end
