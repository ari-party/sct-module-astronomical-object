local Starmap = require( 'Module:Starmap' )
local t = require( 'translate' )
local linksUtil = require( 'utils.links' )
local stringUtil = require( 'utils.string' )

---@param args args
---@param object table?
---@return string?
local function getDirection( args, object )
    if args.tunneldirection then return args.tunneldirection end
    if not object or object.type ~= 'JUMPPOINT' then return nil end

    return t( 'val_tunnel_direction_' .. string.lower( object.tunnel.direction ) )
end

---@param args args
---@param object table?
---@return string?
local function getSize( args, object )
    if args.tunnelsize then return args.tunnelsize end
    if not object or object.type ~= 'JUMPPOINT' then return nil end

    return t( 'val_tunnel_size_' .. string.lower( object.tunnel.size ) )
end

---@param args args
---@param object table?
---@return string?
local function getExit( args, object )
    if args.tunnelexit then return args.tunnelexit end
    if not object or object.type ~= 'JUMPPOINT' then return nil end

    local exitObject = object.tunnel.exit
    -- Make sure the exit is not the current object
    if exitObject.code == object.code then exitObject = object.tunnel.entry end

    local exit = linksUtil.convertLinks( { stringUtil.removeParentheses( exitObject.designation ) } )[ 1 ]
    local pathTo = Starmap.pathTo( Starmap.findStructure( 'object', exitObject.code ), true ) -- the `true` is to tell Module:Starmap not to capitalize the first letter

    if string.len( pathTo ) > 0 then
        return stringUtil.clean( exit .. ', ' .. pathTo )
    else
        return stringUtil.clean( exit )
    end
end

---@param infobox any
---@param args args
---@param object table
return function ( infobox, args, object )
    infobox:renderSection( {
        title = t( 'lbl_tunnel' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_tunnel_direction' ),
                data = getDirection( args, object ),
            } ),
            infobox:renderItem( {
                label = t( 'lbl_tunnel_size' ),
                data = getSize( args, object ),
            } ),

            infobox:renderItem( {
                label = t( 'lbl_tunnel_exit' ),
                data = getExit( args, object ),
            } )
        },
        col = 2
    } )
end
