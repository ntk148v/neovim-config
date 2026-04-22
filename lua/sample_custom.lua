local M = {}

-- add extra plugins here
M.plugins = {
    { "Shatur/neovim-ayu" },
    { "kepano/flexoki-neovim", name = "flexoki" },
}

-- add extra configuration options here, like extra autocmds etc.
-- feel free to create your own separate files and require them in here
M.configs = function()
    -- Set colorscheme after options
    vim.cmd("colorscheme flexoki-light")
end

-- add servers to be used for auto formatting here
M.formatting_servers = {
    rust_analyzer = {},
    lua_ls = {},
}

-- add Tree-sitter to auto-install
M.treesitter_parsers = { "toml" }

-- add any null-ls sources you want here
M.setup_sources = function(b)
    return {
        b.formatting.prettier.with({
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        b.formatting.stylua,
    }
end

return M
