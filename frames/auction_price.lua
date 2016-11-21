
local myname, ns = ...


local UNKNOWN = GRAY_FONT_COLOR_CODE.. "???"


local function SetValue(self, recipe_id)
  local link = ns.GetResultItemLink(recipe_id)
  if not link then return self:SetText() end

  local price = GetAuctionBuyout and GetAuctionBuyout(link)
  if not price then return self:SetText(UNKNOWN) end

  local num = ns.GetNumProduced(recipe_id)
  self:SetText(ns.GS(price*num))
end


function ns.CreateAuctionPrice(parent)
  local price = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")

  price.SetValue = SetValue

  return price
end
