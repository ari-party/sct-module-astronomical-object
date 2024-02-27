local Common = require( 'Module:Common' )

local StringUtil = {
    removeParentheses = Common.removeParentheses,
    split = Common.split
}

--- Replace obnoxious characters
---@param str string Input string
---@return string
function StringUtil.clean( str )
    local apostrophe = string.gsub( str, '’', '\'' )
    return apostrophe
end

--- Lower first character
---@param str string Input string
---@return string
function StringUtil.lowerFirst( str )
    return string.lower( string.sub( str, 1, 1 ) ) .. string.sub( str, 2 )
end

return StringUtil
