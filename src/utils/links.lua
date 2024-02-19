local LinksUtil = {}

---@param categories table<string> Plain text categories (Stanton, instead of Category:Stanton)
---@return string categories Categories as internal links)
function LinksUtil.convertCategories( categories )
    local mapped = {}
    for _, category in pairs( categories ) do
        if category ~= nil then
            if string.sub( category, 1, 2 ) ~= '[[' then
                category = string.format( '[[Category:%s]]', category )
            end
            table.insert( mapped, category )
        end
    end
    return table.concat( mapped )
end

---@param links table<string> Plain text links (Stanton, instead of [[Stanton]])
---@return table<string> links Now in [[link]] format
function LinksUtil.convertLinks( links )
    local converted = {}
    for _, link in ipairs( links ) do
        table.insert( converted, string.format( '[[%s]]', link ) )
    end
    return converted
end

return LinksUtil
