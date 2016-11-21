
local myname, ns = ...


local children = {}
local function SetRecipe(self, recipe)
  if not recipe then
    self:Hide()
    return
  end

  local recipe_id = recipe.recipeID
  ns.SetRecipeLearned(recipe_id, recipe.learned)

  for kid in pairs(children[self]) do kid:SetValue(recipe_id) end

  self.recipe_id = recipe.recipeID
  self.recipe = recipe

  if recipe.learned then
    local cooldown, _, num, max = C_TradeSkillUI.GetRecipeCooldown(recipe.recipeID)

    if cooldown or ((max or 0) > 0 and num == 0) then
      self.craftable:SetText(RED_FONT_COLOR_CODE.. "On cooldown")
    else
      self.craftable:SetText("Can craft: ".. ns.ColorNum(recipe.numAvailable))
    end
  else
    self.craftable:SetText()
  end

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

  local name = ns.CreateName(butt)
  name:SetPoint("TOPLEFT", item, "TOPRIGHT", 5, 0)
  name:SetPoint("RIGHT", butt, -5, 0)
  kids[name] = true

  butt.craftable = butt:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  butt.craftable:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -4)

  local stock = ns.CreateStockCount(butt)
  stock:SetPoint("TOPLEFT", butt.craftable, "BOTTOMLEFT", 0, -4)
  kids[stock] = true

  butt.costlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.costlabel:SetPoint("TOP", butt.craftable)
  butt.costlabel:SetPoint("RIGHT", butt, "RIGHT", -5, 0)
  butt.costlabel:SetText("Cost")

  butt.auctionlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  butt.auctionlabel:SetPoint("TOPRIGHT", butt.costlabel, "BOTTOMRIGHT", 0, -4)
  butt.auctionlabel:SetText("AH")

  local cost = ns.CreateCost(butt)
  cost:SetPoint("TOPRIGHT", butt.costlabel, "TOPLEFT", -5, 0)

  local ah = ns.CreateAuctionPrice(butt)
  ah:SetPoint("TOP", butt.auctionlabel)
  ah:SetPoint("RIGHT", cost)
  kids[ah] = true

  butt.SetRecipe = SetRecipe
  butt:SetScript("PreClick", PreClick)
  butt:SetScript("PostClick", PostClick)

  butt:RegisterForClicks("AnyDown")

  return butt
end
