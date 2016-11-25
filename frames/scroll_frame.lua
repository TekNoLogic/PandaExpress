
local myname, ns = ...


local NUM_BUTTONS = 8


local buttons = {}
local dirty
local offset = 0


local function Refresh()
  for i,butt in pairs(buttons) do butt:SetRecipe(ns.GetRecipe(i+offset)) end
end


local dirty
local function UpdateScrollbar(self)
	if dirty then self:SetValue(0) end
	dirty = false

	self:SetMinMaxValues(0, math.max(0, ns.GetNumRecipes() - NUM_BUTTONS))
end


local function ResetScrollbar(self)
	dirty = true
end


local function OnDetailsRefresh()
  -- Tiny delay to allow tekReagentCost to scan all the recipes
  C_Timer.After(.01, Refresh)
end


local function OnRecipeListUpdated(self)
  UpdateScrollbar(self)
  Refresh()
end


local function OnValueChanged(self, value)
  offset = value
  Refresh()
end


function ns.CreateScrollFrame(parent)
  local frame = CreateFrame("Frame", nil, parent)

  for i=1,NUM_BUTTONS do
    local butt = ns.CreateCraftButton(frame)
    butt:SetPoint("LEFT")
    butt:SetPoint("RIGHT", -24, 0)
    if i == 1 then
      butt:SetPoint("TOP")
    else
      butt:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -7)
    end

    buttons[i] = butt
  end


	local scrollbar = ns.CreateScrollBar(frame)
	scrollbar:SetPoint("TOP", 0, -13)
	scrollbar:SetPoint("BOTTOM", 0, 11)
	scrollbar:SetPoint("RIGHT", -5, 0)
	scrollbar:SetValueStep(NUM_BUTTONS/2)
	scrollbar:SetStepsPerPage(2)
	scrollbar:AttachOnMouseWheel(frame)

	scrollbar.OnValueChanged = OnValueChanged


  frame:SetScript("OnShow", ResetScrollbar)

  ns.RegisterCallback("_TRADESKILL_DETAILS_REFRESH", OnDetailsRefresh)
  ns.RegisterCallback(scrollbar, "_RECIPE_LIST_UPDATED", OnRecipeListUpdated)

  return frame
end
