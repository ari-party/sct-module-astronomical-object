local common = require( 'Module:Common' )
local t = require( 'translate' )
local tableUtil = require( 'utils.table' )

---@param args args
---@param object table?
---@return string?
local function getAxialTilt( args, object )
    if args.axialtilt then return args.axialtilt end

    local axialTilt = tableUtil.safeAccess( object, 'axial_tilt' )
    if not axialTilt or axialTilt == 0 then return nil end

    return mw.ustring.format( '%.3f', common.formatNum( axialTilt ) ) .. '°'
end

---@param args args
---@param object table?
---@return string?
local function getOrbitalPeriod( args, object )
    if args.orbitalperiod then return args.orbitalperiod end

    local orbitalPeriod = tableUtil.safeAccess( object, 'orbit_period' )
    if not orbitalPeriod or orbitalPeriod <= 0 then return nil end

    return mw.ustring.format( '%s', common.formatNum( orbitalPeriod ) ) .. ' SED'
end

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    --- Atmosphere
    smwData[ t( 'lbl_atmosphere' ) ] = args.atmosphere
    --- Atmospheric pressure
    smwData[ t( 'lbl_atmospheric_pressure' ) ] = args.atmosphericpressure
    --- Density
    smwData[ t( 'lbl_density' ) ] = args.density

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

    --- Equatorial radius
    smwData[ t( 'lbl_equatorial_radius' ) ] = args.equatorialradius
    --- Sidereal rotation
    smwData[ t( 'lbl_sidereal_rotation' ) ] = args.siderealrotation
    --- Sidereal day
    smwData[ t( 'lbl_sidereal_day' ) ] = args.siderealday
    --- Axial tilt
    local axialTilt = getAxialTilt( args, object )
    smwData[ t( 'lbl_axial_tilt' ) ] = axialTilt
    --- Tidally locked
    smwData[ t( 'lbl_tidally_locked' ) ] = args.tidallylocked

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
                data = axialTilt
            } ),
            infobox:renderItem( {
                label = t( 'lbl_tidally_locked' ),
                data = args.tidallylocked
            } ),
        },
        col = 2
    } )

    --- Orbital period
    local orbitalPeriod = getOrbitalPeriod( args, object )
    smwData[ t( 'lbl_orbital_period' ) ] = orbitalPeriod
    --- Orbital speed
    smwData[ t( 'lbl_orbital_speed' ) ] = args.orbitalspeed
    --- Orbital radius
    smwData[ t( 'lbl_orbital_radius' ) ] = args.orbitalradius
    --- Orbital eccentricity
    smwData[ t( 'lbl_orbital_eccentricity' ) ] = args.orbitaleccentricity
    --- Aphelion
    smwData[ t( 'lbl_aphelion' ) ] = args.aphelion
    --- Perihelion
    smwData[ t( 'lbl_perihelion' ) ] = args.perihelion
    --- Inclination
    smwData[ t( 'lbl_inclination' ) ] = args.inclination

    infobox:renderSection( {
        title = t( 'lbl_orbital_parameters' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_orbital_period' ),
                data = orbitalPeriod
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
