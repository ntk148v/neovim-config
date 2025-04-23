local M = {}

M.merge_tables = function(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then return end
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

M.lighten = function(hex, factor)
    -- Remove # if present
    hex = hex:gsub("#", "")

    -- Convert hex to RGB
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    -- Apply lighten factor
    r = math.min(255, math.floor(r + (255 - r) * factor))
    g = math.min(255, math.floor(g + (255 - g) * factor))
    b = math.min(255, math.floor(b + (255 - b) * factor))

    -- Convert back to hex
    return string.format("#%02X%02X%02X", r, g, b)
end

M.darken = function(hex, factor)
    -- Remove # if present
    hex = hex:gsub("#", "")

    -- Convert hex to RGB
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    -- Apply darken factor
    r = math.max(0, math.floor(r * (1 - factor)))
    g = math.max(0, math.floor(g * (1 - factor)))
    b = math.max(0, math.floor(b * (1 - factor)))

    -- Convert back to hex
    return string.format("#%02X%02X%02X", r, g, b)
end

return M
