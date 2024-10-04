--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
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
map("n", "<leader>q", ":qa!<CR>", {})
-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", {})
-- Move around splits
map("n", "<leader>wh", "<C-w>h", {})
map("n", "<leader>wj", "<C-w>j", {})
map("n", "<leader>wk", "<C-w>k", {})
map("n", "<leader>wl", "<C-w>l", {})

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>", {})

-- Telescope
-- <leader> is a space now
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, {})
map("n", "<leader>fg", builtin.live_grep, {})
map("n", "<leader>fb", builtin.buffers, {})
map("n", "<leader>fh", builtin.help_tags, {})

-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", {})    -- open/close
map("n", "<leader>nr", ":NvimTreeRefresh<CR>", {})  -- refresh
map("n", "<leader>nf", ":NvimTreeFindFile<CR>", {}) -- search file

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Comment
map("n", "mm", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })
