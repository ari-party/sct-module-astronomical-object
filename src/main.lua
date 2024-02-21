local AstronomicalObject = {}

local Starmap = require( 'Module:Starmap' )
local Infobox = require( 'Module:InfoboxNeue' )
local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local getMetadata = require( 'metadata' )
local starmap = require( 'utils.starmap' )

local characteristicsSection = require( 'sections.characteristics' )
local detailsSection = require( 'sections.details' )
local featuresSection = require( 'sections.features' )
local footerSection = require( 'sections.footer' )
local jumppointSection = require( 'sections.jumppoint' )
local sensorsSection = require( 'sections.sensors' )

---@alias args { affiliation: string?, classification: string?, code: string?, designation: string?, founded: string?, founder: string?, galactapedia: string?, habitable: string?, image: string?, landingzones: string?, location: string?, name: string?, population: string?, satellites: string?, sensordanger: string?, sensoreconomy: string?, sensorpopulation: string?, services: string?, shops: string?, starmap: string?, tunneldirection: string?, tunnelexit: string?, tunnelsize: string?, type: string?, equatorialradius: string?, gravity: string?, atmosphere: string?, atmosphericpressure: string?, siderealday: string?, axialtilt: string?, density: string?, tidallylocked: string?, orbitalperiod: string?, orbitalspeed: string?, orbitalradius: string?, orbitaleccentricity: string?, aphelion: string?, perihelion: string?, inclination: string?, senator: string?, siderealrotation: string? }

---@param args args
---@param object table?
---@return string?
local function infoboxSubtitle( args, object )
    if args.location then return args.location end
    if not object then return nil end
    return Starmap.pathTo( object )
end

---@param infobox any
local function renderError( infobox )
    infobox:renderInfobox( infobox:renderMessage( {
        title = t( 'error_title' ),
        desc = t( 'error_invalid_args_desc' )
    } ) )
end

---@param frame table https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Frame_object
function AstronomicalObject.main( frame )
    ---@type args
    local args = frame:getParent().args

    local infobox = Infobox:new( { placeholderImage = config.placeholder_image } )

    if not (args.code or args.name) then return renderError( infobox ) end

    -- Find the astronomical object
    local object = starmap.findStructure( args )
    if not object then return renderError( infobox ) end

    --- Infobox

    local title = args.name or object.name or args.designation or object.designation or 'Unknown'
    local fullTitle = title
    if (args.name or object.name) and (args.designation or object.designation) then
        fullTitle = fullTitle ..
          ' : ' .. (args.designation or object.designation)
    end

    infobox:renderImage( args.image )
    infobox:renderHeader( {
        title = fullTitle,
        subtitle = infoboxSubtitle( args, object )
    } )

    local type, classification = detailsSection( infobox, args, object )

    infobox:renderSection( {
        content = {
            infobox:renderItem( {
                label = t( 'lbl_services' ),
                data = args.services
            } ),
            infobox:renderItem( {
                label = t( 'lbl_shops' ),
                data = args.shops
            } )
        },
        col = 2
    } )

    jumppointSection( infobox, args, object )
    featuresSection( infobox, args, object )
    sensorsSection( infobox, args, object )
    characteristicsSection( infobox, args, object )

    infobox:renderSection( {
        title = t( 'lbl_history' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_founded' ),
                data = args.founded,
            } ),
            infobox:renderItem( {
                label = t( 'lbl_founder' ),
                data = args.founder,
            } )
        },
        col = 2
    } )

    footerSection( infobox, args, object )

    ---

    local renderedInfobox = infobox:renderInfobox( nil, title )
    local categories = getMetadata( args, object, type, classification )

    return renderedInfobox .. categories
end

function AstronomicalObject.test( args )
    local frame = {}

    function frame:getParent()
        return {
            args = args
        }
    end

    mw.log( AstronomicalObject.main( frame ) )
end

return AstronomicalObject
