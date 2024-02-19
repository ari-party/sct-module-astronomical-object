local t = require( 'translate' )

---@param infobox any
---@param args args
return function ( infobox, args )
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
        col = 3
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
                label = t( 'lbl_sidereal_day' ),
                data = args.siderealday
            } ),
            infobox:renderItem( {
                label = t( 'lbl_axial_tilt' ),
                data = args.axialtilt
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
                data = args.orbitalperiod
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
