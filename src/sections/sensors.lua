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
    if args.sensordanger then return args.sensordanger end
    local value = tableUtil.safeAccess( object, 'sensor_economy' )
    if value > 0 then return tostring( value ) .. '/10' else return nil end
end

---@param args args
---@param object table?
---@return string?
local function getSensorPopulation( args, object )
    if args.sensordanger then return args.sensordanger end
    local value = tableUtil.safeAccess( object, 'sensor_population' )
    if value > 0 then return tostring( value ) .. '/10' else return nil end
end

---@param infobox any
---@param args args
---@param object table?
return function ( infobox, args, object )
    infobox:renderSection( {
        title = t( 'lbl_sensors' ),
        content = {
            infobox:renderItem( {
                label = t( 'lbl_sensor_danger' ),
                data = getSensorDanger( args, object )
            } ),
            infobox:renderItem( {
                label = t( 'lbl_sensor_economy' ),
                data = getSensorEconomy( args, object )
            } ),
            infobox:renderItem( {
                label = t( 'lbl_sensor_population' ),
                data = getSensorPopulation( args, object )
            } )
        },
        col = 3
    } )
end
