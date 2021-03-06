
local myname, ns = ...


local COOLDOWN = RED_FONT_COLOR_CODE.. "On cooldown"


local function GetText(recipe_id)
  if not ns.IsRecipeLearned(recipe_id) then return end

  local cooldown, _, num, max = C_TradeSkillUI.GetRecipeCooldown(recipe_id)
  if cooldown or ((max or 0) > 0 and num == 0) then return COOLDOWN end

  return "Can craft: ".. ns.ColorNum(ns.GetNumCraftable(recipe_id))
end


local function SetValue(self, recipe_id)
  self:SetText(GetText(recipe_id))
end


function ns.CreateNumCraftable(parent)
  local num = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  num.SetValue = SetValue

  return num
end
