
local myname, ns = ...


local BOP = BATTLENET_FONT_COLOR_CODE.."BoP|r "
local UNKNOWN = GRAY_FONT_COLOR_CODE.. "???"


local function GetBOP(recipe_id)
  if not HasBoundReagents then return end

  local link = ns.GetResultItemLink(recipe_id)
  if not link then return end

  local id = ns.ids[link]
  if not id then return end

  if HasBoundReagents(id) then return BOP end
end


local function GetCost(recipe_id)
  local key = "recipe:".. recipe_id
  local cost, incomplete = GetReagentCost and GetReagentCost(key)
  if not cost then return UNKNOWN end

  return (incomplete and "~" or "").. ns.GS(cost)
end


local function SetValue(self, recipe_id)
  local cost = (GetBOP(recipe_id) or "").. GetCost(recipe_id)
  self:SetText(cost)
end


function ns.CreateCost(parent)
  local cost = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")

  cost.SetValue = SetValue

  return cost
end
