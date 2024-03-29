local t = require( 'translate' )
local tableUtil = require( 'utils.table' )

---@param args args
---@param object table?
---@return string?
local function getSensorDanger( args, object )
    if args.sensordanger then return args.sensordanger end
    local value = tableUtil.safeAccess( object, 'sensor_danger' )
    if value > 0 then return tostring( value ) .. '/10' else return nil end
end

---@param args args
---@param object table?
---@return string?
local function getSensorEconomy( args, object )
    if args.sensoreconomy then return args.sensoreconomy end
    local value = tableUtil.safeAccess( object, 'sensor_economy' )
    if value > 0 then return tostring( value ) .. '/10' else return nil end
end

---@param args args
---@param object table?
---@return string?
local function getSensorPopulation( args, object )
    if args.sensorpopulation then return args.sensorpopulation end
    local value = tableUtil.safeAccess( object, 'sensor_population' )
    if value > 0 then return tostring( value ) .. '/10' else return nil end
end

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    --- Sensor: Danger
    local sensorDanger = getSensorDanger( args, object )
    smwData[ t( 'lbl_sensor_danger' ) ] = sensorDanger
    --- Sensor: Economy
    local sensorEconomy = getSensorEconomy( args, object )
    smwData[ t( 'lbl_sensor_economy' ) ] = sensorEconomy
    --- Sensor: Population
    local sensorPopulation = getSensorPopulation( args, object )
    smwData[ t( 'lbl_sensor_population' ) ] = sensorPopulation

    infobox:renderSection( {
        title = t( 'lbl_sensors' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_sensor_danger' ),
                data = sensorEconomy
            } ),
            infobox:renderItem( {
                label = t( 'lbl_sensor_economy' ),
                data = sensorEconomy
            } ),
            infobox:renderItem( {
                label = t( 'lbl_sensor_population' ),
                data = sensorPopulation
            } )
        },
        col = 3
    } )
end
