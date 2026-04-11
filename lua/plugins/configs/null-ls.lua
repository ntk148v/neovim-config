--
-- File: plugins/configs/null-ls.lua
-- Description: none-ls.nvim configuration (null-ls successor)
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

local present, none_ls = pcall(require, "null-ls")
if not present then
    return {}
end

-- Load custom sources if defined
local exist, custom = pcall(require, "custom")
local custom_sources = exist
        and type(custom) == "table"
        and custom.setup_sources
        and custom.setup_sources(none_ls.builtins)
    or {}

local sources = {}

-- Add custom sources
if #custom_sources > 0 then
    for _, source in ipairs(custom_sources) do
        table.insert(sources, source)
    end
end

return { sources = sources }
