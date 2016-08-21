
local myname, ns = ...


function ns.NewCraftButton(parent)
  local butt = CreateFrame("Frame", nil, parent)
  butt:SetHeight(48)

  butt.icon = butt:CreateTexture(nil, "ARTWORK")
  butt.icon:SetPoint("TOPLEFT")
  butt.icon:SetSize(48, 48)

  butt.name = butt:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  butt.name:SetPoint("TOPLEFT", butt.icon, "TOPRIGHT", 5, 0)

  butt.craftable = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.craftable:SetPoint("TOPLEFT", butt.name, "BOTTOMLEFT", 0, -4)

  butt.stock = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.stock:SetPoint("TOPLEFT", butt.craftable, "BOTTOMLEFT", 0, -4)

  butt.costlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.costlabel:SetPoint("TOP", butt.craftable)
  butt.costlabel:SetPoint("RIGHT", butt, "RIGHT", -5, 0)
  butt.costlabel:SetText("Cost")

  butt.auctionlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.auctionlabel:SetPoint("TOPRIGHT", butt.costlabel, "BOTTOMRIGHT", 0, -4)
  butt.auctionlabel:SetText("AH")

  butt.cost = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.cost:SetPoint("TOPRIGHT", butt.costlabel, "TOPLEFT", -5, 0)

  butt.ah = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.ah:SetPoint("TOP", butt.auctionlabel)
  butt.ah:SetPoint("RIGHT", butt.cost)

  local name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(117319)
  butt.icon:SetTexture(icon)
  butt.name:SetText(link)
  butt.craftable:SetText("Can craft: 4")
  butt.stock:SetText("In stock: 1")
  butt.cost:SetText(ns.GS(123456))
  butt.ah:SetText(ns.GS(1234567))

  return butt
end
