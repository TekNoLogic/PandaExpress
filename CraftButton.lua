
local myname, ns = ...


local recipe_ids = {}
local function PreClick(self, button)
  if InCombatLockdown() then return end

  self:SetAttribute("type", "macro")
  self:SetAttribute("macrotext", ns.GenerateMacro(button, recipe_ids[self]))
end


local function PostClick(self, button)
  if InCombatLockdown() then return end
  self:SetAttribute("type", nil)
  self:SetAttribute("macrotext", nil)
end


local children = {}
local function SetRecipe(self, recipe)
  if not recipe then return self:Hide() end

  local recipe_id = recipe.recipeID
  recipe_ids[self] = recipe_id

  ns.SendMessage("_RECIPE_DATA_RECEIVED", recipe_id, recipe)

  for kid in pairs(children[self]) do kid:SetValue(recipe_id) end

  self:Show()
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

  local craftable = ns.CreateNumCraftable(butt)
  craftable:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -4)
  kids[craftable] = true

  local stock = ns.CreateStockCount(butt)
  stock:SetPoint("TOPLEFT", craftable, "BOTTOMLEFT", 0, -4)
  kids[stock] = true

  local costlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  costlabel:SetPoint("TOP", craftable)
  costlabel:SetPoint("RIGHT", butt, "RIGHT", -5, 0)
  costlabel:SetText("Cost")

  local auctionlabel = butt:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  auctionlabel:SetPoint("TOPRIGHT", costlabel, "BOTTOMRIGHT", 0, -4)
  auctionlabel:SetText("AH")

  local cost = ns.CreateCost(butt)
  cost:SetPoint("TOPRIGHT", costlabel, "TOPLEFT", -5, 0)
  kids[cost] = true

  local ah = ns.CreateAuctionPrice(butt)
  ah:SetPoint("TOP", auctionlabel)
  ah:SetPoint("RIGHT", cost)
  kids[ah] = true

  butt.SetRecipe = SetRecipe
  butt:SetScript("PreClick", PreClick)
  butt:SetScript("PostClick", PostClick)

  butt:RegisterForClicks("AnyDown")

  return butt
end
