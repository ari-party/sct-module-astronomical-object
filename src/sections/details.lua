local Yesno = require( 'Module:Yesno' )
local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local linksUtil = require( 'utils.links' )
local stringUtil = require( 'utils.string' )
local tableUtil = require( 'utils.table' )

---@param args args
---@param object table?
---@return string? type
---@return string? classification
local function getType( args, object )
    local plainType = args.type
    if not plainType and object then plainType = object.type end

    local translatedType = nil
    if plainType then translatedType = t( 'val_type_' .. mw.ustring.lower( plainType ) ) end

    return plainType, translatedType
end

---@param args args
---@param object table?
---@param type string?
---@return string?
local function getClassification( args, object, type )
    if args.classification then return args.classification end
    if not object then return nil end

    local possibleClassification = tableUtil.safeAccess( object, 'subtype', 'name' )
    if not possibleClassification then return nil end
    if possibleClassification == type then return nil end

    return config.subtype_rename[ possibleClassification ] or possibleClassification
end

---@param args args
---@param object table?
---@return string?
local function getAffiliation( args, object )
    local affiliation = stringUtil.split( args.affiliation or '', ',' ) -- Is an empty table if the arg isn't defined
    if #affiliation == 0 then
        if not object then return nil end
        for _, empire in ipairs( object.affiliation ) do table.insert( affiliation, empire.name ) end
    end
    return table.concat( linksUtil.convertLinks( affiliation ), ', ' )
end

---@param args args
---@param object table?
---@return table
local function getSMWAffiliation( args, object )
    local affiliation = stringUtil.split( args.affiliation or '', ',' )
    if #affiliation == 0 then
        if not object then return {} end
        for _, empire in ipairs( object.affiliation ) do table.insert( affiliation, empire.name ) end
    end
    return affiliation
end

---@param args args
---@param object table?
---@return string?
local function getHabitable( args, object )
    local habitable = nil

    if args.habitable then
        habitable = Yesno( args.habitable )
    elseif
        object then
        habitable = object.habitable
    end

    if habitable ~= nil then
        return t( 'val_habitable_' .. tostring( habitable ) )
    else
        return nil
    end
end

---@param infobox any
---@param args args
---@param object table?
---@return string? type Plain type
---@return string? translatedType Translated type
---@return string? classification Classification
return function ( infobox, args, object )
    local plainType, translatedType = getType( args, object )
    --- Type
    smwData[ t( 'lbl_type' ) ] = plainType
    --- Classification
    local classification = getClassification( args, object, plainType )
    smwData[ t( 'lbl_classification' ) ] = classification
    --- Affiliation
    smwData[ t( 'lbl_affiliation' ) ] = getSMWAffiliation( args, object )
    --- Habitable
    local habitable = getHabitable( args, object )
    smwData[ t( 'lbl_habitable' ) ] = habitable
    --- Population
    smwData[ t( 'lbl_population' ) ] = args.population
    --- Senator
    smwData[ t( 'lbl_senator' ) ] = args.senator

    infobox:renderSection( {
        content = {
            infobox:renderItem( {
                label = t( 'lbl_type' ),
                data = translatedType,
            } ),
            infobox:renderItem( {
                label = t( 'lbl_classification' ),
                data = classification,
            } ),

            infobox:renderItem( {
                label = t( 'lbl_affiliation' ),
                data = getAffiliation( args, object ),
            } ),
            infobox:renderItem( {
                label = t( 'lbl_habitable' ),
                data = habitable,
            } ),

            infobox:renderItem( {
                label = t( 'lbl_population' ),
                data = args.population,
            } ),
            infobox:renderItem( {
                label = t( 'lbl_senator' ),
                data = args.senator,
            } )
        },
        col = 2
    } )

    return plainType, translatedType, classification
end
