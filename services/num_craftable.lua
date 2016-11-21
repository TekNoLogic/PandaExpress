
local myname, ns = ...


local available = {}
local function OnDataReceived(self, event, recipe_id, data)
  available[recipe_id] = data.numAvailable
end


function ns.GetNumCraftable(recipe_id)
  return available[recipe_id]
end


ns.RegisterCallback("_RECIPE_DATA_RECEIVED", OnDataReceived)
