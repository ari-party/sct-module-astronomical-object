local StringUtil = {}

--- Remove parentheses and their content
---@param inputString string
---@return string
function StringUtil.removeParentheses( inputString )
    return string.match( string.gsub( inputString, '%b()', '' ), '^%s*(.*%S)' ) or ''
end

--- Split a string with seperator
---@param str string Input string
---@param sep string Seperator
---@return table<string>
function StringUtil.split( str, sep )
    local matches = {}
    for matchedString in string.gmatch( str, '([^' .. sep .. ']+)' ) do
        table.insert( matches, string.gsub( matchedString, '%b()', '' ) or '' )
    end
    return matches
end

return StringUtil
