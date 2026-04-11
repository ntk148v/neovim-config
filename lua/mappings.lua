--
-- ███╗   ██║███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: mappings.lua
-- Description: Key mapping configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local map = vim.keymap.set

-- ─── Window Navigation ──────────────────────────────────────────────────
map("n", "<leader>wh", "<C-w>h", { desc = "Switch [W]indow left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Switch [W]indow down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Switch [W]indow up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Switch [W]indow right" })

-- ─── Reload Config ──────────────────────────────────────────────────────
function _G.reload_config()
    local reload = require("plenary.reload").reload_module

    -- Reload all config modules
    local modules = { "options", "mappings", "autocmds", "plugins", "utils", "custom" }
    for _, name in ipairs(modules) do
        if package.loaded[name] then
            reload(name)
        end
    end

    -- Re-source init.lua to re-bootstrap lazy.nvim
    dofile(vim.env.MYVIMRC)
    vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
end
map("n", "rr", _G.reload_config, { desc = "[R]eload configuration without restart" })

-- ─── Telescope ──────────────────────────────────────────────────────────
-- (Keybindings are now defined in plugins/init.lua via lazy.nvim `keys`)
-- Additional advanced mappings defined inline:

map("n", "<leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>s/", function()
    require("telescope.builtin").live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, { desc = "[S]earch [/] in Open Files" })

map("n", "<leader>sn", function()
    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- ─── Mini.files ─────────────────────────────────────────────────────────
-- (Keybindings are now defined in plugins/init.lua via lazy.nvim `keys`)

-- ─── Formatting ─────────────────────────────────────────────────────────
map("n", "<leader>l", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

-- ─── Comment ────────────────────────────────────────────────────────────
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment selection", remap = true })

-- ─── Terminal ───────────────────────────────────────────────────────────
map("n", "tt", function()
    local height = math.floor(vim.o.lines / 2)
    vim.cmd("belowright split | resize " .. height .. " | terminal")
end, { desc = "Toggle terminal" })

-- ─── Clear Highlights ───────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- ─── Diagnostics ────────────────────────────────────────────────────────
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
