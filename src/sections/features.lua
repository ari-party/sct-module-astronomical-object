local Starmap = require( 'Module:Starmap' )
local t = require( 'translate' )
local tableUtil = require( 'utils.table' )

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    ---@type string | number
    local landingzones = args.landingzones
    ---@type string | number
    local satellites = args.satellites

    if (not landingzones or not satellites) and object then
        local children = Starmap.children( object.id, false )

        local landingzoneCount = #tableUtil.filter( children, 'type', 'LZ', nil )
        local satelliteCount = #tableUtil.filter( children, 'type', 'SATELLITE', nil )

        if not landingzones and landingzoneCount > 0 then landingzones = landingzoneCount end
        if not satellites and satelliteCount > 0 then satellites = satelliteCount end
    end

    --- Landing zones
    smwData[ t( 'lbl_landing_zones' ) ] = landingzones
    --- Satellites
    smwData[ t( 'lbl_satellites' ) ] = satellites

    infobox:renderSection( {
        content = {
            infobox:renderItem( {
                label = t( 'lbl_landing_zones' ),
                data = landingzones
            } ),
            infobox:renderItem( {
                label = t( 'lbl_satellites' ),
                data = satellites
            } )
        },
        col = 2
    } )
end
