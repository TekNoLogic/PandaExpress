
local myname, ns = ...


local function SetValue(self, recipe_id)
  local min, max = C_TradeSkillUI.GetRecipeNumItemsProduced(recipe_id)
  if (max or 0) > 0 and max ~= min then return self:SetText(min.. "-".. max) end
  if min == 1 then return self:SetText() end
  self:SetText(min)
end


function ns.CreateCraftedQty(parent)
  local qty = parent:CreateFontString(nil, "ARTWORK", "NumberFontNormal")

  qty.SetValue = SetValue

  return qty
end
