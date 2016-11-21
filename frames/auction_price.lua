
local myname, ns = ...


local UNKNOWN = GRAY_FONT_COLOR_CODE.. "???"


local function SetValue(self, recipe_id)
  local link = ns.GetResultItemLink(recipe_id)
  if link then
    local ah = GetAuctionBuyout and GetAuctionBuyout(link)
    local ah_price = ah and ns.GS(ah) or UNKNOWN
    self.ah:SetText(ah_price)
  else
    self.ah:SetText()
  end
end


function ns.CreateAuctionPrice(parent)
  local price = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")

  price.SetValue = SetValue

  return price
end
