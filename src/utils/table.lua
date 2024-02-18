local TableUtil = {}

--- Filter table
---@param array table
---@param key string
---@param value any
---@param zero any Value to return if zero matches
function TableUtil.filter(array, key, value, zero)
    local matches = {}
    if array then
        for _, item in ipairs(array) do
            if item[key] == value then
                table.insert(matches, item)
            end
        end
    end
    if zero and #matches == 0 then
        return zero
    else
        return matches
    end
end

--- Alternative for doing table[key][key], this returns nil instead of an error if it doesn't exist
---@param object table?
---@param ... string
function TableUtil.safeAccess(object, ...)
    local value = object
    if not value then return end
    for _, key in ipairs({ ... }) do
        value = value[key]
        if value == nil then return nil end
    end
    return value
end

return TableUtil
