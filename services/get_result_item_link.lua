
local myname, ns = ...


function ns.CreatesScroll(recipe_id)
  return not not ns.vellums[recipe_id]
end


function ns.GetResultItemLink(recipe_id)
  if ns.CreatesScroll(recipe_id) then
    local _, link = GetItemInfo(ns.vellums[recipe_id])
    return link
  end

  return C_TradeSkillUI.GetRecipeItemLink(recipe_id)
end
