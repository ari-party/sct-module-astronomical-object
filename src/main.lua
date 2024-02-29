local AstronomicalObject = {}

local Starmap = require( 'Module:Starmap' )
local Infobox = require( 'Module:InfoboxNeue' )
local config = mw.loadJsonData( 'Module:Astronomical object/config.json' )
local t = require( 'translate' )
local getMetadata = require( 'metadata' )
local tableUtil = require( 'utils.table' )
local stringUtil = require( 'utils.string' )

local characteristicsSection = require( 'sections.characteristics' )
local detailsSection = require( 'sections.details' )
local featuresSection = require( 'sections.features' )
local footerSection = require( 'sections.footer' )
local jumppointSection = require( 'sections.jumppoint' )
local sensorsSection = require( 'sections.sensors' )

---@alias args { affiliation: string?, classification: string?, code: string?, designation: string?, founded: string?, founder: string?, galactapedia: string?, habitable: string?, image: string?, landingzones: string?, location: string?, name: string?, population: string?, satellites: string?, sensordanger: string?, sensoreconomy: string?, sensorpopulation: string?, services: string?, shops: string?, starmap: string?, tunneldirection: string?, tunnelentry: string?, tunnelexit: string?, tunnelsize: string?, type: string?, equatorialradius: string?, gravity: string?, atmosphere: string?, atmosphericpressure: string?, siderealday: string?, axialtilt: string?, density: string?, tidallylocked: string?, orbitalperiod: string?, orbitalspeed: string?, orbitalradius: string?, orbitaleccentricity: string?, aphelion: string?, perihelion: string?, inclination: string?, senator: string?, siderealrotation: string? }

---@param args args
---@param object table?
---@return string?
local function infoboxSubtitle( args, object )
    if args.location then return args.location end
    if not object then return nil end
    return stringUtil.clean( Starmap.pathTo( object ) )
end

---@param infobox any
local function renderError( infobox )
    return infobox:renderInfobox( infobox:renderMessage( {
        title = t( 'error_title' ),
        desc = t( 'error_invalid_args_desc' )
    } ) )
end

---@param frame table https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Frame_object
function AstronomicalObject.main( frame )
    ---@type args
    local args = frame:getParent().args

    local infobox = Infobox:new( { placeholderImage = config.placeholder_image } )

    local pageTitle = mw.title.getCurrentTitle().text
    local searchParameter = args.code or args.name or pageTitle

    if not searchParameter then return renderError( infobox ) end

    -- Find the astronomical object
    local object = Starmap.findStructure( 'object', searchParameter )
    if not object then return renderError( infobox ) end

    --- Infobox

    local title = stringUtil.clean(
        args.name or
        object.name or
        args.designation or
        object.designation or
        pageTitle or
        'Unknown'
    )

    local fullTitle = title
    if (args.name or object.name) and (args.designation or object.designation) ~= (args.name or object.name) then
        fullTitle = fullTitle ..
            ' : ' .. stringUtil.clean( args.designation or object.designation )
    end

    infobox:renderImage( args.image )
    infobox:renderHeader( {
        title = fullTitle,
        subtitle = infoboxSubtitle( args, object )
    } )

    local type, translatedType, classification = detailsSection( infobox, args, object )

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
    local categories, shortDesc = getMetadata(
        object,
        type,
        translatedType,
        classification
    )

    frame:callParserFunction(
        'SHORTDESC',
        stringUtil.clean( stringUtil.removeParentheses( shortDesc ) )
    )

    return renderedInfobox .. categories
end

return AstronomicalObject
