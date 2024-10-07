local M = {}

-- add extra plugins here
M.plugins = {
    { "Shatur/neovim-ayu" }
}

-- add extra configuration options here, like extra autocmds etc.
-- feel free to create your own separate files and require them in here
M.configs = function()
    require("ayu").colorscheme()
end

-- add servers to be used for auto formatting here
M.formatting_servers = {
    rust_analyzer = {},
    lua_ls = {},
}

-- add Tree-sitter to auto-install
M.ensure_installed = { "toml" }

-- add any null-ls sources you want here
M.setup_sources = function(b)
    return {
        b.formatting.autopep8,
        b.formatting.prettier.with {
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
        },
        b.formatting.black.with {
            extra_args = { "--fast" }
        },
        b.formatting.stylua,
    }
end

return M
