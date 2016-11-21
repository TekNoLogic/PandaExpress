
local myname, ns = ...


local learned_recipes = {}
function ns.GetRecipeLearned(recipe_id)
  return learned_recipes[recipe_id]
end


function ns.SetRecipeLearned(recipe_id, learned)
  learned_recipes[recipe_id] = learned
end
