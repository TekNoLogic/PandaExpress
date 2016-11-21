
local myname, ns = ...


local learned = {}
local function OnDataReceived(self, event, recipe_id, data)
  learned[recipe_id] = data.learned
end


function ns.IsRecipeLearned(recipe_id)
  return learned[recipe_id]
end


ns.RegisterCallback("_RECIPE_DATA_RECEIVED", OnDataReceived)
