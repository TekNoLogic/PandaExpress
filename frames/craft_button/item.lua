
local myname, ns = ...



local myname, ns = ...


local function GetVellumTexture(recipe_id)
  if not ns.CanUseVellum(recipe_id) then return end
  local link = ns.GetResultItemLink(recipe_id)
  if not link then return end

  local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(link)
  return texture
end


local function GetTexture(recipe_id)
  local vellum = GetVellumTexture(recipe_id)
  if vellum then return vellum end

  local info = C_TradeSkillUI.GetRecipeInfo(recipe_id)
  return info.icon
end


local textures = ns.NewMemoizingTable(GetTexture)


local links = {}
local function OnEnter(self)
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 48)
  GameTooltip:SetHyperlink(links[self])
end


local icons = {}
local qtys = {}
local function SetValue(self, recipe_id)
  links[self] = ns.GetResultItemLink(recipe_id)
  icons[self]:SetTexture(textures[recipe_id])
  qtys[self]:SetValue(recipe_id)
end


function ns.CreateItem(parent)
  local item = CreateFrame("Frame", nil, parent)

  item:SetScript("OnEnter", OnEnter)
  item:SetScript("OnLeave", GameTooltip_Hide)

  local icon = item:CreateTexture(nil, "ARTWORK")
  icon:SetAllPoints()
  icons[item] = icon

  local qty = ns.CreateCraftedQty(item)
  qty:SetPoint("BOTTOMRIGHT", -3, 3)
  qtys[item] = qty

  item.SetValue = SetValue

  return item
end
