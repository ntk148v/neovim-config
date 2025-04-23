if vim.fn.has "nvim-0.8" == 0 then error "Need Neovim 0.8+ in order to use this config" end

for _, cmd in ipairs { "git", "rg", { "fd", "fdfind" } } do
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

    if not found then error(("`%s` is not installed"):format(name)) end
end

vim.opt.termguicolors = true -- enable 24-bit RGB colors
-- Disable annoying deprecated message
vim.deprecate = function() end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Load default configurations and plugins
for _, source in ipairs {
    "plugins",
    "options",
    "mappings",
    "autocmds",
} do
    local ok, fault = pcall(require, source)
    if not ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

-- Load custom configurations
local exist, custom = pcall(require, "custom")
if exist and type(custom) == "table" and custom.configs then custom.configs() end
