local M = {}

M.plugins = {
    { "Shatur/neovim-ayu" }
}

M.configs = function()
    require("ayu").colorscheme()
end

M.formatting_servers = {
    ["rust_analyzer"] = { "rust" },
    ["lua_ls"] = { "lua" },
    ["null_ls"] = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
}

M.ensure_installed = {}

return M
