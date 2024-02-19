local StarmapUtil = {}

local Starmap = require( 'Module:Starmap' )

---@param args args
---@return table?
function StarmapUtil.findStructure( args )
    return Starmap.findStructure( 'object', args.code or args.name )
end

return StarmapUtil
