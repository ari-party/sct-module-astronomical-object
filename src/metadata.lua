local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local linksUtil = require( 'utils.links' )
local stringUtil = require( 'utils.string' )
local tableUtil = require( 'utils.table' )
local pluralize = require( 'utils.pluralize' )

--- Modified version of sections.details' getAffilation
---@param args args
---@param object table?
---@return table
local function getAffiliation( args, object )
    local affiliation = stringUtil.split( args.affiliation or '', ',' )
    if #affiliation == 0 then
        if not object then return {} end
        for _, empire in ipairs( object.affiliation ) do table.insert( affiliation, empire.name ) end
    end
    return affiliation
end

---@param args args
---@param object table?
---@param type string?
---@param translatedType string?
---@param classification string?
---@param parent table?
---@return string categories
---@return string shortDesc
return function ( args, object, type, translatedType, classification, parent )
    --- SMW
    mw.smw.set( {
        [ t( 'lbl_starmap_id' ) ] = tableUtil.safeAccess( object, 'id' ),
        [ t( 'lbl_starmap_code' ) ] = tableUtil.safeAccess( object, 'code' ),
        [ t( 'lbl_affiliation' ) ] = getAffiliation( args, object ),
        [ t( 'lbl_type' ) ] = type,
        [ t( 'lbl_classification' ) ] = classification
    } )

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
        local unknown = t( 'val_unknown' )

        -- Has a parent that isn't a star
        if parent.type ~= 'STAR' then
            if tableUtil.contains( config.planetary_types, object.type ) then -- Planetary based
                shortDesc = mw.ustring.format(
                    t( 'lbl_shortdesc_on' ),
                    translatedType,
                    parent.name or parent.designation or unknown,
                    object.star_system.name
                )
            else -- Space station or something
                shortDesc = mw.ustring.format(
                    t( 'lbl_shortdesc_orbiting' ),
                    translatedType,
                    parent.name or parent.designation or unknown,
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
