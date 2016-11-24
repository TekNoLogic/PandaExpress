
local myname, ns = ...


local NUM_BUTTONS = 8


local buttons = {}
local dirty
local offset = 0
local recipes = {}
local function RebuildList()
  wipe(recipes)

  for i,recipe in ipairs(TradeSkillFrame.RecipeList.dataList) do
    if recipe.recipeID then
      table.insert(recipes, recipe)
    end
  end
end


local function Refresh()
  for i,butt in pairs(buttons) do butt:SetRecipe(recipes[i+offset]) end
end


local function OnMouseWheel(self, value)
  local max = #recipes - NUM_BUTTONS
  offset = offset - value * NUM_BUTTONS / 2
  if offset > max then offset = max end
  if offset < 0 then offset = 0 end
  Refresh()
end


local function OnRebuildDataList()
  if dirty then
    offset = 0
    dirty = false
  end
  RebuildList()
  Refresh()
end


local function OnRefreshDisplay()
  -- Tiny delay to allow tekReagentCost to scan all the recipes
  C_Timer.After(.01, Refresh)
end


local function OnShow()
  dirty = true
end


function ns.CreateScrollFrame(parent)
  local frame = CreateFrame("Frame", nil, parent)

  for i=1,NUM_BUTTONS do
    local butt = ns.CreateCraftButton(frame)
    butt:SetPoint("LEFT")
    butt:SetPoint("RIGHT")
    if i == 1 then
      butt:SetPoint("TOP")
    else
      butt:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -7)
    end

    buttons[i] = butt
  end

  frame:EnableMouse(true)
  frame:EnableMouseWheel(true)
  frame:SetScript("OnMouseWheel", OnMouseWheel)
  frame:SetScript("OnShow", OnShow)

  hooksecurefunc(TradeSkillFrame.RecipeList, "RebuildDataList", OnRebuildDataList)
  hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshDisplay", OnRefreshDisplay)

  return frame
end
