local t = require( 'translate' )
local tableUtil = require( 'utils.table' )

---@param args args
---@param object table?
---@return string?
local function getAxialTilt( args, object )
    if args.axialtilt then return args.axialtilt end

    local axialTilt = tableUtil.safeAccess( object, 'axial_tilt' )
    if not axialTilt then return nil end

    return string.format( '%.3f', axialTilt ) .. '°'
end

---@param args args
---@param object table?
---@return string?
local function getOrbitalPeriod( args, object )
    if args.orbitalperiod then return args.orbitalperiod end

    local orbitalPeriod = tableUtil.safeAccess( object, 'orbit_period' )
    if not orbitalPeriod then return nil end

    return string.format( '%d', orbitalPeriod ) .. ' SED'
end

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    infobox:renderSection( {
        title = t( 'lbl_atmospheric_properties' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_atmosphere' ),
                data = args.atmosphere
            } ),
            infobox:renderItem( {
                label = t( 'lbl_atmospheric_pressure' ),
                data = args.atmosphericpressure
            } ),
            infobox:renderItem( {
                label = t( 'lbl_density' ),
                data = args.density
            } ),
        },
        col = 2
    } )

    infobox:renderSection( {
        title = t( 'lbl_physical_characteristics' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_equatorial_radius' ),
                data = args.equatorialradius
            } ),
            infobox:renderItem( {
                label = t( 'lbl_gravity' ),
                data = args.gravity
            } ),

            infobox:renderItem( {
                label = t( 'lbl_sidereal_rotation' ),
                data = args.siderealrotation
            } ),
            infobox:renderItem( {
                label = t( 'lbl_sidereal_day' ),
                data = args.siderealday
            } ),

            infobox:renderItem( {
                label = t( 'lbl_axial_tilt' ),
                data = getAxialTilt( args, object )
            } ),
            infobox:renderItem( {
                label = t( 'lbl_tidally_locked' ),
                data = args.tidallylocked
            } ),
        },
        col = 2
    } )

    infobox:renderSection( {
        title = t( 'lbl_orbital_parameters' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_orbital_period' ),
                data = getOrbitalPeriod( args, object )
            } ),
            infobox:renderItem( {
                label = t( 'lbl_orbital_speed' ),
                data = args.orbitalspeed
            } ),

            infobox:renderItem( {
                label = t( 'lbl_orbital_radius' ),
                data = args.orbitalradius
            } ),
            infobox:renderItem( {
                label = t( 'lbl_orbital_eccentricity' ),
                data = args.orbitaleccentricity
            } ),

            infobox:renderItem( {
                label = t( 'lbl_aphelion' ),
                data = args.aphelion
            } ),
            infobox:renderItem( {
                label = t( 'lbl_perihelion' ),
                data = args.perihelion
            } ),

            infobox:renderItem( {
                label = t( 'lbl_inclination' ),
                data = args.inclination
            } )
        },
        col = 2
    } )
end
