local Common = require( 'Module:Common' )

local TableUtil = {
    safeAccess = Common.safeAccess
}

--- Filter table
---@param array table
---@param key string
---@param value any
---@param zero any Value to return if zero matches
function TableUtil.filter( array, key, value, zero )
    local matches = {}
    if array then
        for _, item in ipairs( array ) do
            if item[ key ] == value then
                table.insert( matches, item )
            end
        end
    end
    if zero and #matches == 0 then
        return zero
    else
        return matches
    end
end

--- Value is in table
---@param array table<any>
---@param target any
---@return boolean
function TableUtil.contains( array, target )
    for _, value in ipairs( array ) do
        if value == target then
            return true
        end
    end

    return false
end

return TableUtil
