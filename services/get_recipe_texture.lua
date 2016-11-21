
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
function ns.GetRecipeTexture(recipe_id)
  return textures[recipe_id]
end
