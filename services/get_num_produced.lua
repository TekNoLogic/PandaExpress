
local myname, ns = ...


function ns.GetNumProduced(recipe_id)
  -- Why oh why does the API return the enchant power for the "number of items
  -- produced"?  Weird-ass random Blizzard inconsistancy.
  if ns.CanUseVellum(recipe_id) then return 1 end

  return C_TradeSkillUI.GetRecipeNumItemsProduced(recipe_id)
end
