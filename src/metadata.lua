local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local linksUtil = require( 'utils.links' )
local stringUtil = require( 'utils.string' )
local tableUtil = require( 'utils.table' )
local pluralize = require( 'utils.pluralize' )

---@param object table?
---@param type string?
---@param translatedType string?
---@param classification string?
---@return string categories
---@return string shortDesc
return function ( object, type, translatedType, classification )
    local parent = (object or {}).parent

    --- SMW
    smwData[ t( 'lbl_starmap_id' ) ] = tableUtil.safeAccess( object, 'id' )
    smwData[ t( 'lbl_starmap_code' ) ] = tableUtil.safeAccess( object, 'code' )

    mw.smw.set( smwData )

    --- Categories
    local categories = { 'Astronomical objects', 'Locations' } -- Defaults

    if classification then table.insert( categories, pluralize( classification ) ) end

    local systemName = tableUtil.safeAccess( object, 'star_system', 'name' )
    if systemName then
        table.insert(
            categories,
            stringUtil.clean( stringUtil.removeParentheses( systemName ) ) .. ' system'
        )
    end

    if type then table.insert( categories, pluralize( t( 'val_type_' .. mw.ustring.lower( type ) ) ) ) end

    local shortDesc = ''
    if translatedType and object and tableUtil.safeAccess( object, 'star_system', 'name' ) and parent then
        -- Has a parent that isn't a star
        if parent.type ~= 'STAR' then
            if tableUtil.contains( config.planetary_types, object.type ) then -- Planetary based
                shortDesc = mw.ustring.format(
                    t( 'lbl_shortdesc_on' ),
                    translatedType,
                    parent.name or parent.designation or t( 'val_unknown' ),
                    object.star_system.name
                )
            else -- Space station or something
                shortDesc = mw.ustring.format(
                    t( 'lbl_shortdesc_orbiting' ),
                    translatedType,
                    parent.name or parent.designation or t( 'val_unknown' ),
                    object.star_system.name
                )
            end
        else -- Planet or asteroid belt or of sorts (decendant of the system's star)
            shortDesc = mw.ustring.format(
                t( 'lbl_shortdesc_in' ),
                translatedType,
                object.star_system.name
            )
        end
    end

    return linksUtil.convertCategories( categories ), shortDesc
end
