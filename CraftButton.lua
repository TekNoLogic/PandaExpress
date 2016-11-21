
local myname, ns = ...


local UNKNOWN = GRAY_FONT_COLOR_CODE.. "???"


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


local function ColorNum(num)
  local color = (num > 0) and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE
  return color.. num.. "|r"
end


local children = {}
local function SetRecipe(self, recipe)
  if not recipe then
    self:Hide()
    return
  end

  local recipe_id = recipe.recipeID

  for kid in pairs(children[self]) do kid:SetValue(recipe_id) end

  self.recipe_id = recipe.recipeID
  self.recipe = recipe

  self.name:SetText(recipe.name)

  local link = ns.GetResultItemLink(recipe_id)
  if link and ns.CanUseVellum(recipe_id) then
    local name = GetItemInfo(link)
    self.name:SetText(name:gsub("^Enchant ", ""))
  end

  if recipe.learned then
    local cooldown, _, num, max = C_TradeSkillUI.GetRecipeCooldown(recipe.recipeID)

    if cooldown or ((max or 0) > 0 and num == 0) then
      self.craftable:SetText(RED_FONT_COLOR_CODE.. "On cooldown")
    else
      self.craftable:SetText("Can craft: ".. ColorNum(recipe.numAvailable))
    end

    if link then
      local stock = GetItemCount(link, true) + GetNumAuctions(link)
      self.stock:SetText("In stock: ".. ColorNum(stock))
    else
      self.stock:SetText()
    end
  else
    self.craftable:SetText()
    self.stock:SetText()
  end

  local cost, incomplete = GetReagentCost and GetReagentCost("recipe:"..recipe.recipeID)
  local reagent_price = cost and ns.GS(cost) or UNKNOWN
  if incomplete then reagent_price = "~"..reagent_price end
  local id = link and ns.ids[link]
  if cost and id and HasBoundReagents and HasBoundReagents(id) then
    reagent_price = BATTLENET_FONT_COLOR_CODE.."BoP|r "..reagent_price
  end
  self.cost:SetText(reagent_price)

  self:Show()
end


local function PreClick(self, button)
  if InCombatLockdown() then return end

  if button == "LeftButton" and (self.recipe.numAvailable > 0) then
    macro = "/run C_TradeSkillUI.CraftRecipe(".. self.recipe_id.. ")"
    if self.is_enchant then macro = macro.. "\n/use item:38682" end

    self:SetAttribute("type", "macro")
    self:SetAttribute("macrotext", macro)

  elseif button == "RightButton" or (self.recipe.numAvailable == 0) then
    macro = "/run "..
      "TradeSkillFrame.RecipeList:SetSelectedRecipeID(".. self.recipe_id.. ") "..
      "TradeSkillFrame.RecipeList:ForceRecipeIntoView(".. self.recipe_id.. ")"
    self:SetAttribute("type", "macro")
    self:SetAttribute("macrotext", macro)
  end
end


local function PostClick(self, button)
  if InCombatLockdown() then return end
  self:SetAttribute("type", nil)
  self:SetAttribute("macrotext", nil)
end


function ns.CreateCraftButton(parent)
  local butt = CreateFrame("CheckButton", nil, parent, "SecureActionButtonTemplate")
  butt:SetHeight(48)

  local kids = {}
  children[butt] = kids

  local item = ns.CreateItem(butt)
  item:SetPoint("TOPLEFT")
  item:SetSize(48, 48)
  kids[item] = true

  butt.name = butt:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  butt.name:SetPoint("TOPLEFT", item, "TOPRIGHT", 5, 0)
  butt.name:SetPoint("RIGHT", butt, -5, 0)
  butt.name:SetJustifyH("LEFT")
  butt.name:SetWordWrap(false)

  butt.craftable = butt:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  butt.craftable:SetPoint("TOPLEFT", butt.name, "BOTTOMLEFT", 0, -4)

  butt.stock = butt:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
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

  local ah = ns.CreateAuctionPrice(butt)
  ah:SetPoint("TOP", butt.auctionlabel)
  ah:SetPoint("RIGHT", butt.cost)
  kids[ah] = true

  butt.SetRecipe = SetRecipe
  butt:SetScript("PreClick", PreClick)
  butt:SetScript("PostClick", PostClick)

  butt:RegisterForClicks("AnyDown")

  return butt
end
