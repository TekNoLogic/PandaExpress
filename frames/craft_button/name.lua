
local myname, ns = ...


local function GetVellumName(recipe_id)
  if not ns.CanUseVellum(recipe_id) then return end

  local link = ns.GetResultItemLink(recipe_id)
  if not link then return end

  local name = GetItemInfo(link)
  if not name then return end

  return name:gsub("^Enchant ", "")
end


local function GetName(recipe_id)
  local vellum = GetVellumName(recipe_id)
  if vellum then return vellum end

  local info = C_TradeSkillUI.GetRecipeInfo(recipe_id)
  return info.name
end


local names = ns.NewMemoizingTable(GetName)


local function SetValue(self, recipe_id)
  self:SetText(names[recipe_id])
end


function ns.CreateName(parent)
  local name = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  name:SetJustifyH("LEFT")
  name:SetWordWrap(false)

  name.SetValue = SetValue

  return name
end
