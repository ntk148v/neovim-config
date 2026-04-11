--- Utility functions
local M = {}

--- Deep-merge t2 into t1 (mutates t1 in place)
---@param t1 table
---@param t2 table
---@return table t1
M.merge_tables = function(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return t1
    end
    for k, v in pairs(t2) do
        if type(v) == "table" and type(t1[k]) == "table" then
            M.merge_tables(t1[k], v)
        else
            t1[k] = v
        end
    end
    return t1
end

--- Lighten a hex color
---@param hex string
---@param factor number 0-1
---@return string
M.lighten = function(hex, factor)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    r = math.min(255, math.floor(r + (255 - r) * factor))
    g = math.min(255, math.floor(g + (255 - g) * factor))
    b = math.min(255, math.floor(b + (255 - b) * factor))
    return string.format("#%02X%02X%02X", r, g, b)
end

--- Darken a hex color
---@param hex string
---@param factor number 0-1
---@return string
M.darken = function(hex, factor)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    r = math.max(0, math.floor(r * (1 - factor)))
    g = math.max(0, math.floor(g * (1 - factor)))
    b = math.max(0, math.floor(b * (1 - factor)))
    return string.format("#%02X%02X%02X", r, g, b)
end

return M
