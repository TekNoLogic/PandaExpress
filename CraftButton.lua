
local myname, ns = ...


local UNKNOWN = GRAY_FONT_COLOR_CODE.. "???"


local function SetRecipe(self, recipe_id)
  self.recipe_id = recipe_id
  if not recipe_id then return end

  local recipe = C_TradeSkillUI.GetRecipeInfo(recipe_id)
  self.recipe = recipe

  self.icon:SetTexture(recipe.icon)
  self.name:SetText(recipe.name)

  if recipe.learned then
    self.craftable:SetText("Can craft: ".. recipe.numAvailable)

    local cost, incomplete = GetReagentCost and GetReagentCost("recipe:"..recipe_id)
    local reagent_price = cost and ns.GS(cost) or UNKNOWN
    if incomplete then reagent_price = "~"..reagent_price end
    self.cost:SetText(reagent_price)

    local link = C_TradeSkillUI.GetRecipeItemLink(recipe_id)
    if link then
      local stock = GetItemCount(link, true)
      self.stock:SetText("In stock: ".. stock)

      local ah = GetAuctionBuyout and GetAuctionBuyout(link)
      local ah_price = ah and ns.GS(ah) or UNKNOWN
      self.ah:SetText(ah_price)
    else
      self.stock:SetText()
    end
  else
    self.craftable:SetText()
    self.stock:SetText()
  end
end


function ns.NewCraftButton(parent)
  local butt = CreateFrame("Frame", nil, parent)
  butt:SetHeight(48)

  butt.icon = butt:CreateTexture(nil, "ARTWORK")
  butt.icon:SetPoint("TOPLEFT")
  butt.icon:SetSize(48, 48)

  butt.name = butt:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  butt.name:SetPoint("TOPLEFT", butt.icon, "TOPRIGHT", 5, 0)
  butt.name:SetPoint("RIGHT", butt, -5, 0)
  butt.name:SetJustifyH("LEFT")
  butt.name:SetWordWrap(false)

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

  butt.SetRecipe = SetRecipe

  return butt
end
