
local myname, ns = ...


local server = GetRealmName().." "..UnitFactionGroup("player")
local function GetNumAuctions(link)
  local id = ns.ids[link]
  local count = 0

  if id and ForSaleByOwnerDB then
    for char,vals in pairs(ForSaleByOwnerDB[server]) do
      count = count + (vals[id] or 0)
    end
  end

  return count
end


local function GetText(recipe_id)
  if not ns.GetRecipeLearned(recipe_id) then return end

  local link = ns.GetResultItemLink(recipe_id)
  if not link then return end

  local stock = GetItemCount(link, true) + GetNumAuctions(link)
  return "In stock: ".. ns.ColorNum(stock)
end


local function SetValue(self, recipe_id)
  self:SetText(GetText(recipe_id))
end


function ns.CreateStockCount(parent)
  local stock = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  stock.SetValue = SetValue

  return stock
end
