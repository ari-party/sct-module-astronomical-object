local Starmap = require( 'Module:Starmap' )
local t = require( 'translate' )
local tableUtil = require( 'utils.table' )

---@param args args
---@param object table?
---@return string?
local function getStarmapLink( args, object )
    if not object then return end
    return Starmap.link( object.code, object.star_system.code )
end

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    infobox:renderFooter( {
        content = {
            infobox:renderItem( {
                label = t( 'lbl_starmap_id' ),
                data = tableUtil.safeAccess( object, 'id' ),
                row = true,
                spacebetween = true
            } ),
            infobox:renderItem( {
                label = t( 'lbl_starmap_code' ),
                data = tableUtil.safeAccess( object, 'code' ),
                row = true,
                spacebetween = true
            } ),
        },

        button = {
            icon = 'WikimediaUI-Globe.svg',
            label = t( 'lbl_other_sites' ),
            type = 'popup',
            content = infobox:renderSection( {
                content = {
                    infobox:renderItem( {
                        label = t( 'lbl_official_sites' ),
                        data = table.concat( {
                            infobox:renderLinkButton( {
                                label = t( 'lbl_starmap' ),
                                link = getStarmapLink( args, object )
                            } ),
                            infobox:renderLinkButton( {
                                label = t( 'lbl_galactapedia' ),
                                link = args.galactapedia
                            } )
                        }, ' ' )
                    } ),
                },
                class = 'infobox__section--linkButtons',
            }, true )
        }
    } )
end
