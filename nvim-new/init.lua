if vim.fn.has('nvim-0.8') == 0 then
    error('Need Neovim 0.8+ in order to use this config')
end

for _, cmd in ipairs({"git", "rg", {"fd", "fdfind"}}) do
    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
    local commands = type(cmd) == "string" and {cmd} or cmd
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

vim.g.mapleader = " "
vim.opt.termguicolors = true -- enable 24-bit RGB colors

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({{
    import = "plugins"
}}, lazy_config)

require "options"
vim.schedule(function()
    require "mappings"
end)
