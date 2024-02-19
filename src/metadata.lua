local t = require( 'translate' )
local linksUtil = require( 'utils.links' )
local stringUtil = require( 'utils.string' )
local tableUtil = require( 'utils.table' )

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
---@param classification string?
---@return string
return function ( args, object, type, classification )
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

    if classification then table.insert( categories, classification ) end

    local systemName = tableUtil.safeAccess( object, 'star_system', 'name' )
    if systemName then table.insert( categories, systemName .. ' system' ) end

    return linksUtil.convertCategories( categories )
end
