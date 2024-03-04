local Starmap = require( 'Module:Starmap' )
local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local stringUtil = require( 'utils.string' )

---@param args args
---@param object table?
---@return string?
local function getDirection( args, object )
    if args.tunneldirection then return args.tunneldirection end
    if not object or object.type ~= 'JUMPPOINT' then return nil end

    return t( 'val_tunnel_direction_' .. mw.ustring.lower( object.tunnel.direction ) )
end

---@param args args
---@param object table?
---@return string?
local function getSize( args, object )
    if args.tunnelsize then return args.tunnelsize end
    if not object or object.type ~= 'JUMPPOINT' then return nil end

    return t( 'val_tunnel_size_' .. mw.ustring.lower( object.tunnel.size ) )
end

---@param args args
---@param object table?
---@return string? entry
---@return string? entryCode
---@return string? exit
---@return string? exitCode
local function getEntryAndExit( args, object )
    local entry = args.tunnelentry
    local entryCode
    local exit = args.tunnelexit
    local exitCode

    if object and object.type == 'JUMPPOINT' then
        if not entry then
            entry = '[[' .. stringUtil.clean(
                stringUtil.removeParentheses( object.tunnel.entry.designation )
            ) .. ']], ' .. Starmap.inSystem(
                Starmap.findStructure( 'system', object.tunnel.entry.star_system_id )
            )

            entryCode = object.tunnel.entry.code
        end

        if not exit then
            exit = stringUtil.clean(
                '[[' .. stringUtil.removeParentheses( object.tunnel.exit.designation ) .. ']], ' ..
                Starmap.inSystem(
                    Starmap.findStructure( 'system', object.tunnel.exit.star_system_id )
                )
            )

            exitCode = object.tunnel.exit.code
        end
    end

    return entry, entryCode, exit, exitCode
end

---@param infobox any
---@param args args
---@param object table
return function ( infobox, args, object )
    --- Direction
    local direction = getDirection( args, object )
    smwData[ t( 'lbl_jumpgate_direction' ) ] = direction
    --- Size
    local size = getSize( args, object )
    smwData[ t( 'lbl_jumpgate_size' ) ] = size
    --- Exit
    local entry, entryCode, exit, exitCode = getEntryAndExit( args, object )
    smwData[ t( 'lbl_jumpgate_entry' ) ] = entryCode
    smwData[ t( 'lbl_jumpgate_exit' ) ] = exitCode

    local directionIcon = config.tunnelDirectionIcons[ object.tunnel.direction ] or ''

    infobox:renderSection( {
        title = t( 'lbl_jumpgate' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_jumpgate_direction' ),
                data = direction .. ' ' .. directionIcon,
            } ),
            infobox:renderItem( {
                label = t( 'lbl_jumpgate_size' ),
                data = size,
            } ),

            infobox:renderItem( {
                label = t( 'lbl_jumpgate_entry' ),
                data = entry,
            } ),
            infobox:renderItem( {
                label = t( 'lbl_jumpgate_exit' ),
                data = exit,
            } )
        },
        col = 2
    } )
end
