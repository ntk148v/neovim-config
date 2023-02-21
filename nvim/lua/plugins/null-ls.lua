return { -- Use Neovim as a language server to inject LSP diagnostics,
-- code actions, and more via Lua.
{
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {"williamboman/mason.nvim", "nvim-lua/plenary.nvim"},
    lazy = true,
    config = function()
        local null_ls = require("null-ls")
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = null_ls.builtins.formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup({
            debug = false,
            sources = {formatting.prettier.with {
                extra_filetypes = {"toml"},
                extra_args = {"--no-semi", "--single-quote", "--jsx-single-quote"}
            }, formatting.black.with {
                extra_args = {"--fast"}
            }, formatting.stylua, formatting.google_java_format, diagnostics.flake8}
        })
    end
}}
